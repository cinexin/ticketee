class Project < ActiveRecord::Base

	# Validations!
	validates :name, presence: true
end
