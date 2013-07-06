class FieldSubscriptionsController < ApplicationController

  include ActionController::Live

  def show
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['X-Accel-Buffering'] = 'no'
    @field = field

    Redis.new(:timeout => 0).tap do |redis|
      redis.subscribe("field:#{field.id}") do |on|
        on.message do |_, data|
          response.stream.write("data:#{ data }\n\n")
        end
      end
    end

  rescue IOError
    # If the client cancels the connection we'll get his
  ensure
    response.stream.close
  end

  def field
    Field.find(params[:id])
  end


end
