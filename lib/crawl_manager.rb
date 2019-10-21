  require_relative 'crawl_manager/url_frontier'

module CrawlManager
  # Queue Name
  QUEUE_CRAWL_NAME = 'crawler-queue'.freeze
  QUEUE_EXTRACT_NAME = 'extractor-queue'.freeze

  # Score constants
  SCORE_CRAWL_DEFAULT = 10.0
  SCORE_CRAWL_SEED    = SCORE_CRAWL_DEFAULT * 2
  SCIRE_EXTRACT_DEFAULT = 10.0
end
