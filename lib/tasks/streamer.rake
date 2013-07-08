namespace :streamer do

  def forever
    "#{streamer_path}node_modules/forever/bin/forever"
  end

  def streamer
    "#{streamer_path}server.js"
  end

  def streamer_log
    "#{Rails.root}/log/streamer.log"
  end

  def streamer_path
    "#{Rails.root}/streamer/"
  end

  task :start => :environment do
    puts 'Starting the streamer...'
    exec "#{forever} -e #{streamer_log} -o #{streamer_log} start #{streamer}"
  end

  task :stop => :environment do
    puts 'Stopping the streamer'
    exec "#{forever} -e #{streamer_log} -o #{streamer_log} stop #{streamer}"
  end

  task :setup => :environment do
    puts 'Setting up NodeJS Streamer'
    exec "cd #{streamer_path} && npm install"
  end

end