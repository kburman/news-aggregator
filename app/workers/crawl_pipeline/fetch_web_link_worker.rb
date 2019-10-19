module CrawlPipeline
  class FetchWebLinkWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'fetch_web_content'

    # link_item = {'link_id' => 1084, 'full_link' =>"https://scroll.in/"}
    def perform(link_item)
      response = HTTParty.get(URI.parse(link_item['full_link']), follow_redirects: true)
      atrr = {
        web_link_id: link_item['link_id'],
        response_headers: response.headers.to_json,
        response_body: response.body,
        body_size: response.size,
        content_type: response.content_type,
        scraped_at: Time.now
      }

      web_content = WebContent.create!(**atrr)
      PriorityQueue.new(CrawlManager::EXTRACT_QUEUE_NAME).insert_or_incr(link_item['link_id'], CrawlManager::CRAWL_DEFAULT_SCORE)
      PriorityQueue.new(CrawlManager::EXTRACT_QUEUE_NAME).insert_or_incr(web_content.id, CrawlManager::EXTRACT_DEFAULT_SCORE)
    end
  end

end
