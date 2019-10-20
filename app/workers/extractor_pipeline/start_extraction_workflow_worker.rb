module ExtractorPipeline
  class StartExtractionWorkflowWorker
    include Sidekiq::Worker

    # Number of URL to take from queue for processing
    EXTRACT_TASK_NUM = 1000

    def perform
      queue = PriorityQueue.new(CrawlManager::EXTRACT_QUEUE_NAME)
      extract_tasks = queue.pop_max_bulk(EXTRACT_TASK_NUM)
      query = WebContent.where(id: extract_tasks.map(&:first), content_type: 'text/html')
                .joins(:web_link)
                .select(:id, 'web_links.web_domain_id')
      web_domain_mapping = query.group_by { |web_content| web_content.web_domain_id }

      extract_batch = Sidekiq::Batch.new
      extract_batch.description = "HTML Extraction pipeline"
      extract_batch.jobs do
        NullWorker.perform_async
        web_domain_mapping.each do |web_domain_id, web_content|
          web_content_ids = web_content.map(&:id)
          DomainExtractWorker.perform_async(web_domain_id, web_content_ids)
        end
      end
    end
  end
end
