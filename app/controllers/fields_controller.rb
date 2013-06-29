class FieldsController < ApplicationController

  before_filter :authenticate_user!

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
    @field = Field.new height: 30, width: 31, mines: 150
    redirect_to @field if @field.save
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