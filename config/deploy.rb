# Automatic Bundling
require 'bundler/capistrano'
load 'config/recipes/puma'
load 'config/recipes/assets'
load 'config/recipes/postgresql'

#=====================
#       Config       =
#=====================
set :application, 'bombvacuum'
set :scm, :git
set :repository,  'git@github.com:benfalk/bombsvacuum.git'
set :branch, 'master'
set :ssh_options, forward_agent: true
set :stage, :production
set :user, 'deployer'
set :use_sudo, false
set :runner, 'deploy'
set :deploy_to, "/home/deployer/apps/#{application}"
set :app_server, :puma
set :domain, 'bombvac.com'

#=====================
#       Roles        =
#=====================
role :web, domain                         # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

#========================
#CUSTOM
#========================
#namespace :puma do
#  desc 'Start Puma'
#  task :start, :except => { :no_release => true } do
#    run "sudo /etc/init.d/puma start #{application}"
#  end
#  after 'deploy:start', 'puma:start'
#
#  desc 'Stop Puma'
#  task :stop, :except => { :no_release => true } do
#    run "sudo /etc/init.d/puma stop #{application}"
#  end
#  after 'deploy:stop', 'puma:stop'
#
#  desc 'Restart Puma'
#  task :restart, roles: :app do
#    run "sudo /etc/init.d/puma restart #{application}"
#  end
#  after 'deploy:restart', 'puma:restart'
#
#  desc 'create a shared tmp dir for puma state files'
#  task :after_symlink, roles: :app do
#    run "sudo rm -rf #{release_path}/tmp"
#    run "ln -s #{shared_path}/tmp #{release_path}/tmp"
#  end
#  after 'deploy:create_symlink', 'puma:after_symlink'
#end
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end