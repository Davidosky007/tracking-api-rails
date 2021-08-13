module Data
  extend ActiveSupport::Concern
  def new_data
    @measurements = current_user.measurements.with_units.created_on
    data = Hash.new { |h, k| h[k] = [] }
    @measurements.each do |m|
      data[m.unit.title] << m
    end
  end
end
