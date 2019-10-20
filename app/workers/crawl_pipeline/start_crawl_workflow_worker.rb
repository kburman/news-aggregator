# Fetches top N urls from the `crawler-queue` and start a worker for each domain
module CrawlPipeline
  class StartCrawlWorkflowWorker
    include Sidekiq::Worker

    # Number of URL to take from queue for processing
    CRAWL_TASK_NUM = 1000

    def perform
      queue = PriorityQueue.new(CrawlManager::CRAWLER_QUEUE_NAME)
      crawl_tasks = queue.pop_max_bulk(CRAWL_TASK_NUM)
      query = WebLink.where(id: crawl_tasks.map(&:first))

      domain_hash = query.includes(:web_domain).group_by { |link| link.web_domain_id }
      return if domain_hash.blank?

      crawl_batch = Sidekiq::Batch.new
      crawl_batch.description = "Perodic page crawl"
      crawl_batch.jobs do
        domain_hash.each do |web_domain_id, web_links|
          link_items = web_links.map { |item| { link_id: item.id, full_link: item.full_link.to_s } }
          DomainCrawlerWorker.perform_async(web_domain_id, link_items)
        end
      end
    end
  end

end
