module CrawlManager
  # Queue Name
  CRAWLER_QUEUE_NAME = 'crawler-queue'.freeze
  EXTRACT_QUEUE_NAME = 'extractor-queue'.freeze

  # Score constants
  CRAWL_DEFAULT_SCORE = 1.0
  CRAWL_REFRESH_SCORE = CRAWL_DEFAULT_SCORE*5

  EXTRACT_DEFAULT_SCORE = 1.0
end
