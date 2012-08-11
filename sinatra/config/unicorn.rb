# unicorn_rails -c /data/github/current/config/unicorn.rb -E production -D

rails_env = ENV['RAILS_ENV'] || 'production'

# 16 workers and 1 master
worker_processes (rails_env == 'production' ? 16 : 4)

preload_app true

# Restart any workers that haven't responded in 30 seconds
timeout 30

SINATRA_ROOT = File.expand_path(File.dirname(__FILE__))

# Listen on a Unix data socket
listen "%s/tmp/sockets/unicorn.sock" % SINATRA_ROOT, :backlog => 2048


