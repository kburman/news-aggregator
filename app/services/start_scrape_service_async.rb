class StartScrapeServiceAsync < ApplicationService
  def initialize(scrape_service_id)
    @scrape_service = ScrapeService.includes(:web_domain).find(scrape_service_id)
  end

  def call
    sync_website = Sidekiq::Batch.new
    sync_website.description = "Scrape started for \"#{@scrape_service.web_domain.domain_name}\" (id=#{@scrape_service.id}"

    sync_website.jobs { FetchFrontPageWorker.perform_async(@scrape_service.id) }
  end
end