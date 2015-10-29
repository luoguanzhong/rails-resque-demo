# encoding: utf-8

class DemoJob
  @queue = :low

  def self.perform
    puts "demo job,,,demo job,,,demo job,,,demo job"
    puts "demo job,,,demo job,,,demo job,,,demo job"
  end
end
