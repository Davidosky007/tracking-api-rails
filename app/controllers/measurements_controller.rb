class MeasurementsController < ApplicationController
  include Data
  def index
    render json: { data: new_data, status: :ok }
  end

  def create
    @measurement = current_user.measurements.build(measurement_params)
    # @measurement.unit_id = ActionController::Base.helpers.sanitize(params[:unit_id])
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
