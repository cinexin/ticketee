class Project < ActiveRecord::Base

	# Validations!
	validates :name, presence: true

	# Relationships
	# there are 3 options in wich we can define what rails should do when you delete a model with dependencies
	#  :destroy 
	# 		when you delete a project, it will call the "destroy" method on every associated ticket
	# 		if the tickets have callback operations on destroy, then you should use this option
	#  :delete_all
	# 		when you delete a project, it will delete all the tickets associated with a simple sql statement
	# 		(it's a quicker operation than the "destroy" option)
	#  :nullify
	# 		as you can imagine, this only unassociate the tickets related to the project and set them to nil
	# 		note that the tickets will stay undeleted
	has_many :tickets, dependent: :delete_all

	# permissions control...
	# ":thing" word means: i have * permissions related by the field "thing"
	has_many :permissions, as: :thing
	scope :viewable_by, ->(user) do 
		# you can translate this to the following sql sentence
		# select *
		# from user inner join permissions on user.user_id = permissions.user_id
		# where permissions.action = "view"
		joins(:permissions).where(permissions: {action: "view", user_id: user.id})
	end
end
