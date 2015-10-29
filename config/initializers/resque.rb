unless ENV['LiFT_REDIS_URL'].blank?
  require 'resque'
  require 'resque-scheduler'
  # require 'resque/scheduler/server'

  file = File.join(Rails.root, 'config', 'resque_redis.yml')
  config = YAML::load(ERB.new(File.read(file)).result)
  config = config[Rails.env]

  Dir["#{Rails.root}/app/jobs/*.rb"].each { |job| require job }

  Resque.redis = Redis.new(url: config['redis_url'])
  Resque.redis.namespace = config['redis_namespace']

  Resque::Scheduler.dynamic = true
  Resque.schedule = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))

  Resque.logger.level = Logger::INFO
  Resque.logger.datetime_format = "%Y-%m-%d %H:%M:%S %Z"
end
