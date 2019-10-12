require 'set'

class FetchFrontPageWorker
  include Sidekiq::Worker
  
  def perform(scrape_service_id)
    scrape_service = ScrapeService.includes(:web_domain).find(scrape_service_id)
    scraper_client = scrape_service.scraper_klass.new
    article_links = scraper_client.fetch_front_page
    # Only process link from same domain
    article_links = article_links.filter { |link| link.absolute_url.host == scrape_service.web_domain.domain_name }
    added_links = CreateMissingLinksService.call(article_links)
    return if added_links.blank?

    batch.jobs do
      fetch_article_batch = Sidekiq::Batch.new
      fetch_article_batch.description = "Fetching articles for #{scrape_service.web_domain.domain_name}"

      fetch_article_batch.jobs do
        added_links.each { |web_link| FetchArticleWorker.perform_async(scrape_service_id, web_link.id) }
      end
    end
  end
end
