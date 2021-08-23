class MeasurementSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_by, :created_at, :updated_at
  # model association
  has_many :measures
end
