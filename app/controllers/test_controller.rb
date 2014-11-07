class TestController < ApplicationController
  def index
    Resque.enqueue(DemoWorker)
    @p1 = "TEST"
  end
end