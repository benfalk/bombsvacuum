namespace :puma do

  desc 'Start the application'
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec puma -t 8:32 -b 'unix://#{shared_path}/sockets/puma.sock' -S #{shared_path}/sockets/puma.state --control 'unix://#{shared_path}/sockets/pumactl.sock' >> #{shared_path}/log/puma-#{rails_env}.log 2>&1 &", :pty => false
  end
  after 'deploy:start', 'puma:start'

  desc 'Stop the application'
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec pumactl -S #{shared_path}/sockets/puma.state stop"
  end
  after 'deploy:stop', 'puma:stop'

  desc 'Restart the application'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec pumactl -S #{shared_path}/sockets/puma.state restart"
  end
  after 'deploy:restart', 'puma:restart'

  desc 'Status of the application'
  task :status, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec pumactl -S #{shared_path}/sockets/puma.state stats"
  end
  after 'deploy:status', 'puma:status'


  desc 'Setup puma configuration for this application'
  task :setup, roles: :web do
    run "cd #{shared_path} && mkdir -p sockets && touch sockets/puma.state"
  end
  after 'deploy:setup', 'puma:setup'
  

end
