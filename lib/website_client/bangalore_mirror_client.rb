module WebsiteClient
  class BangaloreMirrorClient < BaseClient
    include HTTParty
    base_uri 'https://bangaloremirror.indiatimes.com/'

    def fetch_front_page_articles
      parsed_dom = Nokogiri::HTML(self.class.get('/'))
      article_links = parsed_dom.css('a[href*="/articleshow/"]')

      article_links.map do |elem|
        LinkItem.new(elem['href'], elem['title'], self.class.base_uri)
      end
    end

    def process_artice(article_link)
      parsed_dom = Nokogiri::HTML(self.class.get(article_link))
      ArticleItem.new(
        parsed_dom.at_css("div[data-articlemsid] h1").text,
        (parsed_dom.at_xpath("//div[@data-articlemsid]/section/following-sibling::div[1]") || parsed_dom.at_css("arttextxml"))&.text,
        LinkItem.new(article_link, '', self.class.base_uri)
      )
    end
  end
end
