module WebModels
  class Link
    include ActiveModel::Validations

    attr_accessor :href, :text, :src_link

    validates :href, presence: true
    validates :full_link, url: { no_local: true, public_suffix: true }
    validates :src_link, url: { no_local: true, public_suffix: true, allow_blank: true }

    def full_link
      base_link = URI.parse(src_link.to_s)
      href_link = URI.parse(href.to_s)

      href_link.scheme ||= base_link.scheme
      href_link.host ||= base_link.host
      href_link.port ||= base_link.port

      href_link.to_s
    end
  end
end
