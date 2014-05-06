class Comment < ActiveRecord::Base
	
	# relationships
	belongs_to :user
	belongs_to :ticket
	
	# validations
	validates :text, :presence=>true

	
end
