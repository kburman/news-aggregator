module WebModels
  class Article
    attr_reader :title, :body, :link_item

    def initialize(title, body, article_link_item)
      @title = title.to_s.strip
      @body = body.to_s.strip
      @link_item = article_link_item
    end
  end  
end