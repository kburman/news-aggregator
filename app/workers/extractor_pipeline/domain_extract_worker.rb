module ExtractorPipeline
  class DomainExtractWorker
    include Sidekiq::Worker

    def perform(web_domain_id, web_content_ids)
      batch.jobs do
        NullWorker.perform_async
        web_content_ids.each { |web_content_id| WebContentHtmlExtractWorker.perform_async(web_content_id) }
      end
    end
  end
end
