require 'resque/tasks'
require 'resque/scheduler/tasks'

def run_scheduler
  env_vars = {
    "BACKGROUND" => "1",
    "PIDFILE" => Rails.root.to_s + "/tmp/pids/resque_scheduler.pid",
    "VERBOSE" => "1"
  }
  ops = {
    :pgroup => true,
    :err => [Rails.root.to_s + "/log/resque_scheduler.err.log", "a"],
    :out => [Rails.root.to_s + "/log/resque_scheduler.out.log", "a"]
  }
  pid = spawn(env_vars, "rake resque:scheduler", ops)
  Process.detach(pid)
end

namespace :resque do
  task :setup => :environment

  desc "Stop all resque process"
  task :force_stop do
    `ps aux | grep -ie resque | awk '{print $2}' | xargs kill -9`
  end

  task :stop_scheduler do
    pidfile = Rails.root.to_s + "/tmp/pids/resque_scheduler.pid"
    if !File.exists?(pidfile)
      puts "Scheduler not running"
    else
      pid = File.read(pidfile).to_i
      syscmd = "kill -9 #{pid}"
      begin
        system(syscmd)
        puts "Running syscmd: #{syscmd}"
      rescue => e
      end
      FileUtils.rm_f(pidfile)
    end
  end

  task :start_scheduler do
    run_scheduler
  end

  task :restart_scheduler do
    Rake::Task['resque:stop_scheduler'].invoke
    Rake::Task['resque:start_scheduler'].invoke
  end
end

task 'resque:pool:setup' do
  Resque::Pool.after_prefork do |job|
    Resque.redis.client.reconnect
  end
end
