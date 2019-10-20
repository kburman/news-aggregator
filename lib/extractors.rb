require_relative 'extractors/base_extractor'
require_relative 'extractors/link_extractor'
require_relative 'extractors/news_article_extractor'

module Extractors
  HTML_EXTRACTORS = [
    LinkExtractor,
    NewsArticleExtractor
  ]

  def self.extract_item_from_html(dom, config)
    HTML_EXTRACTORS.map do |extractor|
      extractor.call(dom, config) rescue []
    end.flatten
  end

  def self.process_extracted_items(web_content_id, items)
    item_klass_grouping = items.group_by { |item| item.class.name }
    item_klass_grouping.each do |klass_name, items|
      if klass_name == WebModels::Link.name
        CreateMissingLinksService.call(items)
      else
        puts("Missing processor for #{klass_name}")
      end
    end
  end
end
