class DemoWorker
  @queue = :demo_worker

  def self.perform
    puts "demo_worker,,,demo_worker,,,demo_worker,,,demo_worker"
  end
end