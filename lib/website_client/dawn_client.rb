module WebsiteClient
    class DawnClient < BaseClient
      include HTTParty
      base_uri 'https://www.dawn.com/'
  
      def fetch_front_page_articles
        parsed_dom = Nokogiri::HTML(self.class.get('/'))
        article_links = parsed_dom.css('a[href*="/news/"]')
  
        article_links.map do |elem|
          LinkItem.new(elem['href'], elem['title'], self.class.base_uri)
        end
      end
  
      def process_artice(article_link)
        parsed_dom = Nokogiri::HTML(self.class.get(article_link))
        ArticleItem.new(
          parsed_dom.at_css("div.template__header h2.story__title").text,
          parsed_dom.at_css("div.story__content").text,
          LinkItem.new(article_link, '', self.class.base_uri)
        )
      end
    end
  end
  