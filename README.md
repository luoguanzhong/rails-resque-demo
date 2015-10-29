rails-resque-demo
=================

use resque worker and schudler in rails 3.2.13.

```ruby
gem 'resque', '~> 1.25.2'#, :require => 'resque/server'
gem 'resque-scheduler', '~> 3.0.0'
gem 'resque-pool', '~> 0.6.0'
```

we can use shell code to stop resque:

```bash
# enter someApp folder
cd .../someApp

# stop all resque process
bundle exec rake resque:force_stop

# srart worker and schedule
bundle exec resque-pool --daemon --config config/resque_pool.yml
bundle exec rake resque:start_scheduler
```
