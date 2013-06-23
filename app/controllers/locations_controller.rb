class LocationsController < ApplicationController

  def update
    @location = Location.includes(:field).find(params[:id])
    @location.update(location_params)
    @location.chain_uncover! unless @location.surrounding_mines?
    respond_to do |format|
      format.html { redirect_to @location.field }
      format.js
    end
  end

  private

  def location_params
    params.require(:location).permit(:state)
  end


end