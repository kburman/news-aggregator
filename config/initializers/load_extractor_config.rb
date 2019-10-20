EXTRACTOR_CONFIG = {
  new_items: YAML.load_file(Rails.root.join('config', 'extractor_config', 'news_article.yml'))
}
