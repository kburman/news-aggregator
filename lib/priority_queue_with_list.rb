# Priority queue with with a list where value is a list
class PriorityQueueWithList
  def self.insert_items(key, item_key, item_score, items)
    set_key = "#{key}:priority_queue"
    list_key = "#{key}:#{item_key}:items_list"

    CRAWLER_REDIS_POOL.with do |conn|
      conn.multi do |multi|
        multi.zadd(set_key, item_score, item_key, nx: true)
        multi.lpush(list_key, items)
      end
    end
  end
end
