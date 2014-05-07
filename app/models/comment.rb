class Comment < ActiveRecord::Base
	
	# relationships
	belongs_to :user
	belongs_to :ticket
	belongs_to :state

	# we need a "callback function" to set the ticket state when a coment is created
 	after_create :set_ticket_state
	
	# validations
	validates :text, :presence=>true

	private

    def set_ticket_state
      self.ticket.state = self.state
      self.ticket.save!
    end

end
