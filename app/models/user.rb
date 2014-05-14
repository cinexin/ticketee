class User < ActiveRecord::Base
	# see the "spec/models/user_spec.rb" for details
	validates :email, presence: true
  
	has_secure_password
	
	# association to "permission" model
	has_many :permissions	

	# before and after concerns...
	before_create :generate_token

	# we decided to override the default "to_s" method 
	# view the "app/views/admin/users/index.html.erb" to find out why
	def to_s
	  "#{email} (#{admin? ? "Admin" : "User"})"
	end

	private

	def generate_token
		self.token = SecureRandom.uuid
	end	
end
