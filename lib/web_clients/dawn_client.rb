module WebClients
  class DawnClient
    include HTTParty
    base_uri 'https://www.dawn.com/'

    # @return [WebModels::Link]
    def fetch_front_page
      parsed_dom = Nokogiri::HTML(self.class.get('/'))
      article_links = parsed_dom.css('a.story__link')

      article_links.map { |elem| WebModels::Link.new(elem['href'], self.class.base_uri, elem['title']) }
    end

    # @return WebModels::Article
    def fetch_article(article_url)
      parsed_dom = Nokogiri::HTML(self.class.get(article_url.to_s))
      title = parsed_dom.at_css("div.template__header h2").text
      body = (parsed_dom.at_css("div.template__main"))&.text
      link_item = WebModels::Link.new(article_url, self.class.base_uri, title)

      WebModels::Article.new(title, body, link_item)
    end
  end
end
