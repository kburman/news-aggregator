module Corenlp
  class Client
    include HTTParty
    attr_accessor :lang, :annotators
    base_uri 'localhost:9000'

    def initialize
      @lang = 'en'
      @annotators = Annotator::ALL_ANNOTATORS
    end

    def parse(text)
      properties = {
        annotators: @annotators.join(','),
        outputFormat: :json,
        data: '2019-10-19T01:19:34'
      }
      opt = {
        properties: URI.escape(properties.to_json),
        pipelineLanguage: @lang
      }

      self.class.post("/", :query => opt, :body => text)
    end
  end
end
