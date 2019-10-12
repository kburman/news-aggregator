class CreateMissingLinksService < ApplicationService
  def initialize(link_items)
    @link_items = link_items
  end

  def call
    domain_path_mapping = @link_items.group_by { |item| item.absolute_url.host }
    web_domain_mapping = create_or_find_web_domains(domain_path_mapping.keys)

    added_links = []
    domain_path_mapping.each do |domain_name, link_items|
      link_items.each do |link_item|
        attributes = {
          web_domain: web_domain_mapping[domain_name].first, 
          path: link_item.absolute_url.path,
          scheme: link_item.absolute_url.scheme,
          port: link_item.absolute_url.port
        }

        next if WebLink.where(**attributes).count.positive?
        added_links << WebLink.create!(**attributes)
      end
    end

    puts("Created '#{added_links.length}' new links and given '#{@link_items.length}' links.")

    added_links
  end

  private

  def create_or_find_web_domains(domain_names)
    domain_names.map do |domain_name|
      WebDomain.find_or_create_by!(domain_name: domain_name)
    end.group_by { |item| item.domain_name }
  end
end
