# frozen_string_literal: true

module ExtractorPipeline
  class DomainExtractWorker
    include Sidekiq::Worker

    def perform(web_domain_id, web_links)
      extract_batch = Sidekiq::Batch.new
      extract_batch.description = "Extract Queue for domain #{web_domain_id} with  #{web_links.length} contents."

      batch.jobs do
        extract_batch.jobs do
          NullWorker.perform_async
          web_links.each { |web_link_item| WebContentHtmlExtractWorker.perform_async(web_link_item) }
        end
      end
    end
  end
end
