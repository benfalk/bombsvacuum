class FieldsController < ApplicationController

  # GET /fields
  def index
    @fields = Field.all
  end

  # GET /fields/:id
  def show
    @field = Field.includes(:locations).find(params[:id])
  end

  # GET /fields/new
  def new
    @field = Field.new
  end

  # POST /fields
  def create
    @field = Field.new(field_params)
    respond_to do |format|
      if @field.save
        format.html { redirect_to @field, notice: 'Game On Citizen!' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def field_params
    params.require(:field).permit(:height,:width,:mines)
  end



end