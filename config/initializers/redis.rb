redis_url = ENV.fetch('CRAWL_QUEUE_REDIS_URL')
pool_size = ENV.fetch('CRAWL_REDIS_POOL_SIZE') { 10 }

CRAWLER_REDIS_POOL = ConnectionPool.new(size: pool_size) { Redis.new(url: redis_url) }
