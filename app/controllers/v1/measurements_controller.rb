module V1
  class MeasurementsController < ApplicationController
    before_action :set_measurement, only: %i[show update destroy]

    # GET /measurements
    def index
      @measurements = current_user.measurements.paginate(page: params[:page], per_page: 20)
      json_response(@measurements)
    end

    # POST /measurements
    def create
      @measurement = current_user.measurements.create!(measurement_params)
      json_response(@measurement, :created)
    end

    # GET /measurements/:id
    def show
      json_response(@measurement)
    end

    # PUT /measurements/:id
    def update
      @measurement.update(measurement_params)
      head :no_content
    end

    # DELETE /measurements/:id
    def destroy
      @measurement.destroy
      head :no_content
    end

    private

    def measurement_params
      # whitelist params
      params.permit(:name)
    end

    def set_measurement
      @measurement = Measurement.find(params[:id])
    end
  end
end
