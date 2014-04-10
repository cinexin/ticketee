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
end
