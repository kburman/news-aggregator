# Fetches top `CRAWL_TASK_NUM` urls from the `crawler-queue` and start a worker for each domain
class CrawlPipelineWorker
  include Sidekiq::Worker

  # Number of URL to take from queue for processing
  CRAWL_TASK_NUM = 1000

  def perform
    crawl_tasks = CrawlManager::UrlFrontier.next_crawl_batch(CRAWL_TASK_NUM).to_h
    Rails.logger.info("Found #{crawl_tasks.length} for crawling")
    return if crawl_tasks.blank?

    crawl_links = WebLink.where(id: crawl_tasks.keys).includes(:web_domain)
    crawl_links_json = crawl_links.map do |crawl_link|
      {
        web_domain_id: crawl_link.web_domain_id,
        web_link_id: crawl_link.id,
        full_link: crawl_link.full_link.to_s,
        score: crawl_tasks[crawl_link.id.to_s]
      }
    end
    Rails.logger.info("Found #{crawl_links.length} urls in db out of #{crawl_tasks.length}")
    return if crawl_links_json.blank?

    crawl_batch = Sidekiq::Batch.new
    crawl_batch.description = "Crawler Queue - #{crawl_links.length} URLs"
    web_domain_mapping = crawl_links_json.group_by { |web_link| web_link[:web_domain_id] }

    crawl_batch.jobs do
      web_domain_mapping.each do |web_domain_id, web_links|
        CrawlPipeline::DomainCrawlerWorker.perform_async(web_domain_id, web_links)
      end
    end
  end
end
