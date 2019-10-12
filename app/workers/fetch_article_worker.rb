class FetchArticleWorker
  include Sidekiq::Worker
  
  def perform(scrape_service_id, web_link_id)
    scraper_service = ScrapeService.find(scrape_service_id)
    web_link = WebLink.find(web_link_id)

    client = scraper_service.scraper_klass.new
    article = client.fetch_article(web_link.path)
    WebArticle.create!(
      web_link: web_link, 
      title: article.title,
      body: article.body
    )
    puts(article.title)
  rescue StandardError => ex
    puts(ex.message)
    Rails.logger.error("FetchArticleWorker(#{web_link_id}, #{scrape_service_id}) -Error- #{ex.message}")
  end
end