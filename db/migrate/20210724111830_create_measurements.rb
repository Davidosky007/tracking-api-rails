class CreateMeasurements < ActiveRecord::Migration[6.1]
  def change
    create_table :measurements do |t|
      t.float :value
      t.integer :unit_id
      t.integer :user_id

      t.timestamps
    end
  end
end
