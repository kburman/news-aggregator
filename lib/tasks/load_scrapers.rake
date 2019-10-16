task :load_scrapers => :environment do
  SCRAPER_KLASS = [
    WebClients::TimesOfIndiaClient,
    WebClients::MenXpClient,
    WebClients::EconomicsTimesClient,
    WebClients::News18Client,
    WebClients::TheHinduClient,
    WebClients::ScrollInClient,
    WebClients::DawnClient,
  ]

  SCRAPER_KLASS.each do |klass|
    puts("Loading #{klass}")
    base_uri = URI.parse(klass.base_uri)
    web_domain = WebDomain.find_or_create_by!(domain_name: base_uri.host)
    ScrapeService.find_or_create_by!(web_domain: web_domain, scraper_klass_fq_name: klass.name)
    WebLink.find_or_create_by!(web_domain: web_domain, path: '/', scheme: 'https', port: base_uri.port)
  end
  puts("Finished loading '#{SCRAPER_KLASS.length}' scrapers.")
end
