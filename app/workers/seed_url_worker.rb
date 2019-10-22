# Iterate over all the urls in `SeedUrl` table and add them to `crawler-queue` with
# higher scrore for faster processing.
class SeedUrlWorker
  include Sidekiq::Worker

  def perform
    query = SeedUrl.select(:id, :web_link_id)

    query.find_each(batch_size: 100) do |seed_url|
      CrawlManager::UrlFrontier.append_for_crawl(seed_url.web_link_id, CrawlManager::SCORE_CRAWL_DEFAULT)
    end
  end
end
