class LocationsController < ApplicationController

  def update
    @location = Location.includes(:field).find(params[:id])
    @location.update(location_params)
    redirect_to @location.field
  end

  private

  def location_params
    params.require(:location).permit(:state)
  end


end