# Manage everything related to scheduling url and adding new ones.
module CrawlManager
  class UrlFrontier
    # Return list of link_ids which need to crawled next
    def self.next_crawl_batch(batch_size = 100)
      raise 'Batch size should be atleast 2' if batch_size < 2

      PriorityQueue.pop_max_bulk(CrawlManager::QUEUE_CRAWL_NAME, batch_size)
    end

    # Return list of link_ids which need to extraction next
    def self.next_extract_batch(batch_size = 100)
      raise 'Batch size should be atleast 2' if batch_size < 2

      PriorityQueue.pop_max_bulk(CrawlManager::QUEUE_EXTRACT_NAME, batch_size)
    end

    # Add web_link for crawling with some score.
    # Score can be negative to decrease the priorty
    def self.append_for_crawl(link_id, score)
      PriorityQueue.insert_or_incr(CrawlManager::QUEUE_CRAWL_NAME, link_id, score)
    end

    def self.append_for_extraction(web_link_id, web_content)
      PriorityQueue.insert_or_incr(CrawlManager::QUEUE_EXTRACT_NAME, web_content.id, CrawlManager::SCIRE_EXTRACT_DEFAULT)
    end
  end
end
