class AddDefaultToStates < ActiveRecord::Migration
  def change
  	# by default, we want the "default" field to be false
    add_column :states, :default, :boolean, :default => false
  end
end
