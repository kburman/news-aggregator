class PriorityQueue
  attr_reader :key

  def initialize(key)
    raise 'Invalid key' if key.blank?

    @key = key
    @client = Redis.new(url: ENV.fetch('CRAWL_QUEUE_REDIS_URL'))
  end

  def insert_or_incr(item_key, score)
    @client.zincrby(@key, score, item_key)
  end

  def pop_max
    @client.zpopmax(@key)
  end

  def pop_max_bulk(count)
    raise 'Count cant be zero' if count.zero?

    @client.zpopmax(@key, count)
  end
end
