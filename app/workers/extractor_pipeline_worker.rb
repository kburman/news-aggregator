class ExtractorPipelineWorker
  include Sidekiq::Worker

  # Number of URL to take from queue for processing
  EXTRACT_TASK_NUM = 1000

  def perform
    extract_tasks = CrawlManager::UrlFrontier.next_extract_batch(EXTRACT_TASK_NUM)
    Rails.logger.info("Found #{extract_tasks.length} for extration")
    return if extract_tasks.blank?

    extract_links = WebContent.where(id: extract_tasks.keys, content_type: 'text/html', http_code: 200).includes(web_link: :web_domain)
    extact_link_json = extract_links.map do |extract_link|
      {
        web_domain_id: extract_link.web_link.web_domain_id,
        web_link_id: extract_link.web_link_id,
        full_link: extract_link.web_link.full_link.to_s,
        web_content_id: extract_link.id,
        score: extract_tasks[extract_link.id.to_s]
      }
    end
    Rails.logger.info("Found #{extract_links.length} web_content out of #{extract_tasks.length} given.")
    return if extact_link_json.blank?

    extract_batch = Sidekiq::Batch.new
    extract_batch.description = "Extract Queue - #{extract_links.length} contents."
    web_domain_mapping = extact_link_json.group_by { |web_link| web_link[:web_domain_id] }

    extract_batch.jobs do
      web_domain_mapping.each do |web_domain_id, web_links|
        ExtractorPipeline::DomainExtractWorker.perform_async(web_domain_id, web_links)
      end
    end
  end
end
