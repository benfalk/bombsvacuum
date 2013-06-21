class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.integer :width
      t.integer :height
      t.integer :mines

      t.timestamps
    end
  end
end
