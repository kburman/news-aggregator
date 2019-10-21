module ExtractorPipeline
  class WebContentHtmlExtractWorker
    include Sidekiq::Worker

    # web_link_item = {"web_domain_id"=>1, "web_link_id"=>1, "full_link"=>"https://timesofindia.indiatimes.com/", "web_content_id"=>2456, "score" => 4}
    def perform(web_link_item)
      web_content = WebContent.find(web_link_item['web_content_id'])
      dom = Nokogiri::HTML.parse(web_content.response_body)
      config = {
        full_link: web_link_item['full_link'],
        scraped_at: web_content.scraped_at
      }
      extracted_items = Extractors.extract_item_from_html(dom, config)
      Extractors.process_extracted_items(web_link_item['web_content_id'], extracted_items, web_link_item['score'].to_f)
    end
  end
end
