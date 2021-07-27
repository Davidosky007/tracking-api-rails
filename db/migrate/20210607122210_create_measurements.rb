class CreateMeasurements < ActiveRecord::Migration[6.1]
  def change
    create_table :measurements do |t|
      t.integer :unit_id
      t.integer :user_id
      t.float :value

      t.timestamps
    end
  end
end
