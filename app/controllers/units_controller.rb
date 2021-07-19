class UnitsController < ApplicationController
  def index
    @units = Unit.all
    render json: { units: @units, status: :ok }
  end

  def show
    @unit = Unit.find(params[:id])
    @user = current_user
    @measurements = @unit.measurements.where(user_id: @user.id)
    render json: { unit: @unit, measurements: @measurements }, status: :ok
  end
end
