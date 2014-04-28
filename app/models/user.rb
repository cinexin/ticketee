class User < ActiveRecord::Base
	# see the "spec/models/user_spec.rb" for details
	validates :email, presence: true
  
	has_secure_password
	
	# association to "permission" model
	has_many :permissions	
	# we decided to override the default "to_s" method 
	# view the "app/views/admin/users/index.html.erb" to find out why
	def to_s
	  "#{email} (#{admin? ? "Admin" : "User"})"
	end
end
