rails-resque-demo
=================

use resque worker and schudler in rails 3.2.13.

we can use shell code to stop resque:

```sh
ps aux | grep -ie resque | awk '{print $2}' | xargs kill -9
```
