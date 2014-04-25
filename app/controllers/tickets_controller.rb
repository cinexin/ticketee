class TicketsController < ApplicationController

	# before statements...
	# NOTE: the sequence is important, because we want to retrieve first the project
	# 		and then the ticket
	before_action :set_project
	before_action :set_ticket, only:[:show,:edit,:update,:destroy]
	# note that we can say "only" in these actions or "except" these actions
	# we'll need the "require_signin!" method later, so the best place to put it is in the "application_controller.rb" file
	before_action :require_signin!

	# new action
	def new
		@ticket = Ticket.new(project_id: @project.id)
	end

	# create action
	def create
		@ticket = @project.tickets.build(ticket_params)
		@ticket.user = current_user
		if @ticket.save
			flash[:notice] = "Ticket has been created."
			redirect_to [@project, @ticket]
		else
			flash[:alert] = "Ticket has not been created."
			render "new"
		end
	end

	# the show action
	def show

	end

	# the edit action
	def edit 
	end

	# the update action
	def update

		if (@ticket.update(ticket_params))
			flash[:notice] = "Ticket has been updated."
			redirect_to project_ticket_path(@project, @ticket)
		else
			flash[:alert] = "Ticket has not been updated."
			render action: "edit"
		end
	end

	# the destroy action
	def destroy
		@ticket.destroy
		flash[:notice] = "Ticket has been deleted."

		redirect_to @project
	end



	private
	# this method will being executed before every action
	def set_project
		# the param "project_id" comes from the magic of rails...
		# similar to "params[:id]" in projects controller...
		# the below line isn't valid anymore, since we
		# need to check if the user has view permissions on the project
		# @project = Project.find(params[:project_id])
		@project = Project.for(current_user).find(params[:project_id])
		rescue ActiveRecord::RecordNotFound
		flash[:alert] = "The project you were looking for could not be found."
		redirect_to root_path
	end

	# as above, we define a set_ticket method for retrieving the ticket
	def set_ticket
		@ticket = Ticket.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		flash[:alert] = "The ticket you were looking for could not be found."
		redirect_to projects_path		
	end

	# strong params, always strong params....
	def ticket_params
		params.require(:ticket).permit(:title, :description)
	end
end
