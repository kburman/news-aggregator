module WebModels
  class Link
    include ActiveModel::Validations

    attr_accessor :href, :text, :src_link

    validates :href, presence: true
    validates :full_link, url: { no_local: true, public_suffix: true }
    validates :src_link, url: { no_local: true, public_suffix: true, allow_blank: true }

    def full_link
      URI.join(src_link.to_s, href.to_s).to_s
    rescue URI::InvalidURIError, URI::BadURIError
      href
    end

    def href=(val)
      @href = URI.escape(val.to_s.strip)
    end

    def src_link=(val)
      @src_link = URI.escape(val.to_s.strip)
    end

    def text=(val)
      @text = val.to_s.strip
    end
  end
end
