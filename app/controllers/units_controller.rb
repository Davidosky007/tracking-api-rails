class UnitsController < ApplicationController
  def index
    @units = Unit.all
    render json: { units: @units, status: :ok }
  end

  def show
    @unit = Unit.find(params[:id])
    @user = current_user
    @measurements = @unit.measurements.with_user_id(user)
    render json: { unit: @unit, measurements: @measurements }, status: :ok
  end
end
