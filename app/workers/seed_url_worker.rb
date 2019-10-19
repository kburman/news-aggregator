# Iterate over all the urls in `SeedUrl` table and add them to `crawler-queue` with
# higher scrore for faster processing.
class SeedUrlWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'critical'

  def perform
    crawler_queue = PriorityQueue.new(CrawlManager::CRAWLER_QUEUE_NAME)
    query = SeedUrl.select(:id, :web_link_id)

    query.find_each(batch_size: 100) do |seed_url|
      crawler_queue.insert_or_incr(seed_url.web_link_id, CrawlManager::CRAWL_REFRESH_SCORE)
    end
  end
end
