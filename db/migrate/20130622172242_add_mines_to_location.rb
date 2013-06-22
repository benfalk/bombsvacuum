class AddMinesToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :mines, :integer
  end
end
