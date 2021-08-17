class MeasurementsController < ApplicationController
  before_action :measurement_params

  def index
    @filtereds = current_user.measurements.filter_by_unit(params[:unit_id])
    render json: { data: @filtereds, status: :ok }
  end

  def create
    @measurement = current_user.measurements.build(measurement_params)
    if @measurement.save
      render json: { measurement: @measurement }
    else
      render json: { error: 'Invalid submission' }
    end
  end

  def update
    @measurement = Measurement.find(params[:id])
    @measurement.update(measurement_params)
    render json: { measurement: @measurement }
  end

  def destroy
    @measurement = Measurement.find(params[:id])
    @measurement.destroy
  end

  private

  def measurement_params
    params.permit(:value, :unit_id)
  end
end
