class PriorityQueue
  def self.insert_or_incr(key, item_key, score)
    CRAWLER_REDIS_POOL.with { |conn| conn.zincrby(key, score, item_key) }
  end

  def self.pop_max_bulk(key, count)
    raise 'Count cant be zero' if count < 1

    CRAWLER_REDIS_POOL.with { |conn| conn.zpopmax(key, count) }
  end
end
