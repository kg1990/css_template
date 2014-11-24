class HardWorker
  include Sidekiq::Worker
  sidekiq_options :queue => 'for_test', :retry => true

  def perform(name, count)
    raise name if name == 'crash'
    logger.info "Doing hard work: #{name}"
    sleep count
  end

end
