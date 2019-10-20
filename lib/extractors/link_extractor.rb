module Extractors
  class LinkExtractor < BaseExtractor
    def process
      link_items = @dom.css('a').map do |elem|
        link_item = WebModels::Link.new
        link_item.href = elem['href']
        link_item.text = elem.text
        link_item.src_link = curr_page_link

        link_item
      end

      @processed_items += link_items
    end
  end
end
