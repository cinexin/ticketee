module Admin::PermissionsHelper

	# this method returns a hash with the name and title of 
	# the permissions you want to display in 
	# app/views/admin/permissions/index.html.erb
	def permissions 
		{"view" => "View",}
	end
end
