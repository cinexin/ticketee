class AddAdminToUsers < ActiveRecord::Migration

	def change
		# we want the "admin" field to be false by default, see how we do it 
		# manually "hacking" this auto-generated file
		add_column :users, :admin, :boolean, default: false
	end
end
