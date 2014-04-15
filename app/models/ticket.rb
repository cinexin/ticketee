class Ticket < ActiveRecord::Base
	# relationships
  	belongs_to :project
  	belongs_to :user

  	# validations
  	validates :title, presence: true
  	validates :description, presence: true, length: {minimum:10}
  	# you can do it in one line if you prefer...
  	# validates: :title, :description, presence: true
end
