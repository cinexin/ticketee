class Comment < ActiveRecord::Base
	
	# relationships
	belongs_to :user
	belongs_to :ticket
	belongs_to :state
	# this is how we can define a relationship that Rails cannot infer from the relation name (in this case, Rails would go for "PreviousState" class, wich doesn't exists)
	belongs_to :previous_state, :class_name=>"State"

	# we need a "callback function" to set the ticket state when a coment is created
 	after_create :set_ticket_state
 	# we need another "callback function" to associate the tags from a comment with the ticket when a comment is saved
 	after_create :associate_tags_with_ticket

 	# the before callback function is raised before the creation of the object, but AFTER the validations
 	before_create :set_previous_state
	
	# validations
	validates :text, :presence=>true

	# we need the tag_names (view "app/views/comments/_form.html.erb")
	attr_accessor :tag_names

	private

    def set_ticket_state
      self.ticket.state = self.state
      self.ticket.save!
    end

    def set_previous_state
    	self.previous_state = ticket.state
    end

    def associate_tags_with_ticket
    	if tag_names
    		tags = tag_names.split(" ").map do |name|
    			Tag.find_or_create_by(name:name)
    		end
    		self.ticket.tags += tags
    		self.ticket.save
    	end
    end
end
