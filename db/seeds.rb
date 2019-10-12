SCRAPER_KLASS = [
  WebClients::TimesOfIndiaClient
]

SCRAPER_KLASS.each do |klass|
  base_uri = URI.parse(klass.base_uri)
  web_domain = WebDomain.create!(domain_name: base_uri.host)
  ScrapeService.create!(web_domain: web_domain, scraper_klass_fq_name: klass.name)
  WebLink.create!(web_domain: web_domain, path: '/', scheme: 'https', port: base_uri.port)
end