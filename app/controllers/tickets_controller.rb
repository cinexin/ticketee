class TicketsController < ApplicationController

	# before statements...
	# NOTE: the sequence is important, because we want to retrieve first the project
	# 		and then the ticket
	before_action :set_project
	before_action :set_ticket, only:[:show,:edit,:update,:destroy]

	# new action
	def new
		@ticket = Ticket.new(project_id: @project.id)
	end

	# create action
	def create
		@ticket = @project.tickets.build(ticket_params)
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


	private
	# this method will being executed before every action
	def set_project
		# the param "project_id" comes from the magic of rails...
		# similar to "params[:id]" in projects controller...
		@project = Project.find(params[:project_id])
		rescue ActiveRecord::RecordNotFound
		flash[:alert] = "The project you were looking for could not be found."
		redirect_to projects_path
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
