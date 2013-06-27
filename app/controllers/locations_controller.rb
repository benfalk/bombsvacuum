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
    loop do
      field.locations.where('updated_at > ?', 1.second.ago).each do |loc|
        response.stream.write "data: #{loc.to_json}\n\n"
      end
      sleep 1
    end

  rescue IOError
      # If the client cancels the connection we'll get his
  ensure
    response.stream.close
  end

  private

  def location_params
    params.require(:location).permit(:state)
  end

  def field
    Field.find(params[:field_id])
  end


end