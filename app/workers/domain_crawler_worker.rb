class DomainCrawlerWorker
  include Sidekiq::Worker

  # link_items = [{:link_id=>1084, :full_link=>"https://scroll.in/"}]
  def perform(web_domain_id, link_items)
    return if link_items.blank?

    link_items.each { |link_item| FetchWebLinkWorker.perform_async(link_item) }
    batch.jobs do
    end
  end
end
