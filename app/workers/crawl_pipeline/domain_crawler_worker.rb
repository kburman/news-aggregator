module CrawlPipeline
  class DomainCrawlerWorker
    include Sidekiq::Worker

    # web_links = [{:web_domain_id=>555, :web_link_id=>26965, :full_link=>"http://www.etimes.in"}]
    def perform(web_domain_id, web_links)
      return if web_links.blank?

      batch.jobs do
        crawl_batch = Sidekiq::Batch.new
        crawl_batch.description = "Crawler Queue - #{web_links.length} URLs"
        crawl_batch.jobs do
          web_links.each { |link_item| FetchWebLinkWorker.perform_async(link_item) }
        end
      end
    end
  end
end
