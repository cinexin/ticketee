class User < ActiveRecord::Base

	has_secure_password
	
	# we decided to override the default "to_s" method 
	# view the "app/views/admin/users/index.html.erb" to find out why
	def to_s
	  puts "The user string: " + "#{email} (#{admin? ? "Admin" : "User"})"
	  "#{email} (#{admin? ? "Admin" : "User"})"
	end
end
