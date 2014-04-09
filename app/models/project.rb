class Project < ActiveRecord::Base

	# Validations!
	validates :name, presence: true

	# Relationships
	has_many :tickets
end
