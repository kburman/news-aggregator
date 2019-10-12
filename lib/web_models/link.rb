module WebModels
  class Link
    attr_reader :absolute_url, :base_url
    attr_accessor :link_text

    def initialize(uri, base_url = '', link_text)
      @orig_url = URI.parse(URI.escape(uri.to_s.strip))
      @base_url = URI.parse(URI.escape(base_url.to_s.strip))
      @link_text = link_text

      process_link
    end

    private

    def process_link
      @absolute_url = URI.join(@base_url, @orig_url)
    end
  end  
end