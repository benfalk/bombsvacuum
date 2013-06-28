class LocationsController < ApplicationController

  include ActionController::Live

  def update
    @location = Location.includes(:field).find(params[:id])
    @location.update(location_params)
    @location.chain_uncover! unless @location.surrounding_mines?
    respond_to do |format|
      format.html { redirect_to @location.field }
      format.js
    end
  end

  def subscribe
    response.headers['Content-Type'] = 'text/event-stream'
    @field = field
    loop do
      @field.locations_changed_since( last_update ).each do |loc|
        response.stream.write "data: #{loc.to_json}\n\n"
        self.last_update = loc.updated_at
      end
      sleep 1
    end

  rescue IOError
      # If the client cancels the connection we'll get his
  ensure
    response.stream.close
  end

  private

  def last_update
    session[:field] ||= {}
    session[:field][params[:field_id]] ||= field.updated_at + 2.seconds
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