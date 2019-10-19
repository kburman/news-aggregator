class PriorityQueue
  attr_reader :key

  def initialize(key)
    raise 'Invalid key' if key.blank?

    @key = key
  end

  def insert_or_incr(item_key, score)
    CRAWLER_REDIS_POOL.with { |conn| conn.zincrby(@key, score, item_key) }
  end

  def pop_max
    CRAWLER_REDIS_POOL.with { |conn| conn.zpopmax(@key) }
  end

  def pop_max_bulk(count)
    raise 'Count cant be zero' if count.zero?

    CRAWLER_REDIS_POOL.with { |conn| conn.zpopmax(@key, count) }
  end
end
