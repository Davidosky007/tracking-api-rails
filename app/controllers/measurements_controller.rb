class MeasurementsController < ApplicationController
  before_action :measurement_params

  def index
    @measurements = current_user.measurements.with_units.created_on
    render json: { data: @measurements.as_json(include: :unit), status: :ok }
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
