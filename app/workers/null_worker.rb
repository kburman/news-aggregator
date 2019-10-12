class NullWorker
  include Sidekiq::Worker
  
  def perform; end
end
