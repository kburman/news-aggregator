require_relative 'extractors/base_extractor'
require_relative 'extractors/link_extractor'
require_relative 'extractors/news_article_extractor'

module Extractors
  HTML_EXTRACTORS = [
    LinkExtractor,
    NewsArticleExtractor
  ]

  PROCESSED_ITEMS_QUEUE_PREFIX = 'data-item:'

  def self.extract_item_from_html(dom, config)
    HTML_EXTRACTORS.map do |extractor|
      extractor.call(dom, config) rescue []
    end.flatten
  end

  def self.process_extracted_items(web_content_id, items, score)
    item_klass_grouping = items.group_by { |item| item.class.name }
    item_klass_grouping.each do |klass_name, items|
      queue_name = PROCESSED_ITEMS_QUEUE_PREFIX + klass_name.parameterize
      PriorityQueueWithList.insert_items(web_content_id, items)
      PriorityQueueWithList.insert_items(queue_name, web_content_id, score, items_json)
    end
  end
end
