module V1
  class MeasuresController < ApplicationController
    before_action :set_measurement
    before_action :set_measurement_measure, only: %i[show update destroy]

    # GET /measurements/:measurement_id/measures
    def index
      json_response(@measurement.measures)
    end

    # GET /measurements/:measurement_id/measures/:id
    def show
      json_response(@measure)
    end

    # POST /measurements/:measurement_id/measures
    def create
      @measurement.measures.create!(measure_params)
      json_response(@measurement, :created)
    end

    # PUT /measurements/:measurement_id/measures/:id
    def update
      @measure.update(measure_params)
      head :no_content
    end

    # DELETE /measurements/:measurement_id/measures/:id
    def destroy
      @measure.destroy
      head :no_content
    end

    private

    def measure_params
      params.permit(:value_of_measure)
    end

    def set_measurement
      @measurement = Measurement.find(params[:measurement_id])
    end

    def set_measurement_measure
      @measure = @measurement.measures.find_by!(id: params[:id]) if @measurement
    end
  end
end
