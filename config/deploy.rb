lock "3.10.1"

set :application, 'appple'
set :repo_url, 'git@github.com:yaoyi/appple.git'

# Default branch is :master
# Uncomment the following line to have Capistrano ask which branch to deploy.
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, ENV['rev'] || "master"

# Replace the sample value with the name of your application here:
set :deploy_to, '/u/apps/appple'

# Use agent forwarding for SSH so you can deploy with the SSH key on your workstation.
set :ssh_options, {
  forward_agent: true
}

# Default value for :pty is false
# set :pty, true

set :linked_files, %w{db/production.sqlite3 config/database.yml .ruby-version .env words.trigrams}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :default_env, { path: "/opt/rbenv/shims:$PATH" }

set :keep_releases, 5


set :puma_init_active_record, true
set :puma_user, fetch(:user)
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 2
set :puma_worker_timeout, nil
set :puma_preload_app, true
set :puma_plugins, []  #accept array of plugins
set :nginx_use_ssl, false
