module CrawlPipeline
  class FetchWebLinkWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'fetch_web_content'

    # link_item = {:web_domain_id=>555, :web_link_id=>26965, :full_link=>"http://www.etimes.in"}
    def perform(link_item)
      Rails.logger.debug("Fetching #{link_item['full_link']}")
      response = HTTParty.get(URI.parse(link_item['full_link']), follow_redirects: true)
      atrr = {
        web_link_id: link_item['web_link_id'],
        response_headers: response.headers.to_json,
        response_body: response.body,
        http_code: response.code,
        body_size: response.size,
        content_type: response.content_type,
        scraped_at: Time.now
      }

      web_content = WebContent.create!(**atrr)
      CrawlManager::UrlFrontier.append_for_extraction(link_item['web_link_id'], web_content)
    rescue StandardError => e
      Rails.logger.error("Failed fetching content for #{link_item} #{e.message}")
    end
  end
end
