class FixColumnName < ActiveRecord::Migration
  def change
  	# rename_column table_name, old_column_name, new_column_name
	rename_column :users, :authentication_token, :token
  end
end
