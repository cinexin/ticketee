class CommentsController < ApplicationController

	before_action :require_signin!
	before_action :set_ticket



	def create

		sanitize_parameters!
		
		@comment = @ticket.comments.build(comment_params)
		@comment.user = current_user

		if @comment.save
			flash[:notice] = "Comment has been created."
			redirect_to [@ticket.project, @ticket] 
		else
			@states = State.all
			flash[:alert] = "Comment has not been created."
			render :template => "tickets/show" 
		end
	end



	private

	def set_ticket
		@ticket = Ticket.find(params[:ticket_id])
	end	

	def comment_params
		params.require(:comment).permit(:text, :state_id, :tag_names)
	end

	# we'll remove the forbidden parameters here :-)
	def sanitize_parameters!
		# if the user has not permission to change the state of the ticket, we supress the "state_id" from the params...
		if cannot?(:"change states", @ticket.project)
			params[:comment].delete(:state_id)
		end

		# if the user has not permission to tag, we supress the "tag_names" from the params...
		if cannot?(:tag, @ticket.project)
			params[:comment].delete(:tag_names)
		end	

	end
end
