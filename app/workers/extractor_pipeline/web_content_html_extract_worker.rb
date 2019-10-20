module ExtractorPipeline
  class WebContentHtmlExtractWorker
    include Sidekiq::Worker

    def perform(web_content_id)
      web_content = WebContent.includes(web_link: :web_domain).find(web_content_id)
      dom = Nokogiri::HTML.parse(web_content.response_body)
      config = {
        full_link: web_content.web_link.full_link,
        scraped_at: web_content.scraped_at
      }
      extracted_items = Extractors.extract_item_from_html(dom, config)
      Extractors.process_extracted_items(web_content_id, extracted_items)
    end
  end
end
