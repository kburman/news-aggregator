class StartRefreshWorker
  include Sidekiq::Worker

  def perform
    ScrapeService.all.pluck(:id).each { |scrape_service_id| StartScrapeServiceAsync.call(scrape_service_id) }
  end
end