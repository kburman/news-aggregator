module WebsiteClient
  # Represent web link
  class LinkItem
    attr_reader :text, :link, :base_link

    def initialize(link, text, base_link)
      @link = URI.encode(link.to_s)
      @text = text
      @base_link = URI.encode(base_link.to_s)
    end

    def absolute_url
      @absolute_url ||= begin
        link = URI.join(@base_link, @link)
        link.fragment = nil
        link
      end
    end
  end

  class ArticleItem
    attr_reader :title, :body, :url

    def initialize(title, body, url)
      @title = title
      @body = body
      @url = url
    end
  end

  class BaseClient; end
end
