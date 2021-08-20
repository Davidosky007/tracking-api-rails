class CreateMeasures < ActiveRecord::Migration[6.1]
  def change
    create_table :measures do |t|
      t.string :value_of_measure
      t.references :measurement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
