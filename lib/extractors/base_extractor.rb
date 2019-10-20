module Extractors
  class BaseExtractor
    attr_reader :processed_items

    def initialize(dom, **options)
      @dom = dom
      @options = options
      @processed_items = []
    end

    def self.call(*args, &block)
      obj = new(*args, &block)
      obj.process
      obj.processed_items
    end

    private

    def curr_page_link
      @options[:full_link]
    end
  end
end
