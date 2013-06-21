class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :field_id
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.string :state
      t.boolean :has_mine

      t.timestamps
    end
  end
end
