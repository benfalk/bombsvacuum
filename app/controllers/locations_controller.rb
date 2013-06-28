class LocationsController < ApplicationController

  include ActionController::Live

  def update
    @location = Location.includes(:field).find(params[:id])
    if @location.update(location_params)
      Redis.new.tap do |redis|
        redis.publish("field:#{@location.field_id}", @location.to_json)
        unless @location.surrounding_mines?
          @location.chain_uncover!.each do |location|
            redis.publish("field:#{@location.field_id}", location.to_json)
          end
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to @location.field }
      format.js
    end
  end

  def subscribe
    response.headers['Content-Type'] = 'text/event-stream'
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

  private

  def last_update
    session[:field] ||= {}
    session[:field][params[:field_id]] ||= field.locations.last.updated_at
  end

  def last_update=(update)
    session[:field] ||= {}
    session[:field][params[:field_id]] = [update,last_update].max
  end

  def location_params
    params.require(:location).permit(:state)
  end

  def field
    Field.find(params[:field_id])
  end


end