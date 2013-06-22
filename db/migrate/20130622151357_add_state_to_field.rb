class AddStateToField < ActiveRecord::Migration
  def change
    add_column :fields, :state, :string
  end
end
