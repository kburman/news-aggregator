class CreateMissingLinksService < ApplicationService
  def initialize(link_items)
    @link_items = link_items.select { |link_item| link_item.valid? rescue false }
    @crawl_queue = PriorityQueue.new(CrawlManager::CRAWLER_QUEUE_NAME)
  end

  def call
    domain_path_mapping = @link_items.group_by { |item| URI.parse(item.full_link).host }
    web_domain_mapping = create_or_find_web_domains(domain_path_mapping.keys)

    added_links = []
    domain_path_mapping.each do |domain_name, link_items|
      link_items.each do |link_item|
        link_uri = URI.parse(link_item.full_link)
        attributes = {
          web_domain: web_domain_mapping[domain_name].first,
          path: link_uri.path,
          scheme: link_uri.scheme,
          port: link_uri.port
        }
        next if WebLink.where(path: attributes[:path], web_domain: attributes[:web_domain]).count.positive?

        added_links << WebLink.create!(**attributes)
        @crawl_queue.insert_or_incr(added_links.last.id, CrawlManager::CRAWL_DEFAULT_SCORE)
      end
    end

    added_links
  end

  private

  def create_or_find_web_domains(domain_names)
    domain_names.map do |domain_name|
      WebDomain.find_or_create_by!(domain_name: domain_name)
    end.group_by { |item| item.domain_name }
  end
end
