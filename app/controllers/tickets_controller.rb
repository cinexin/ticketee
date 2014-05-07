class TicketsController < ApplicationController

	# before statements...
	# NOTE: the sequence is important, because we want to retrieve first the project
	# 		and then the ticket
	before_action :require_signin!
	before_action :set_project
	before_action :set_ticket, only:[:show,:edit,:update,:destroy]
	# note that we can say "only" in these actions or "except" these actions
	# we'll need the "require_signin!" method later, so the best place to put it is in the "application_controller.rb" file
	
	# we need to check if the user has permission for "CUD" a ticket
	# see the "private" part of this class to find out the implementation
	before_action :authorize_create!, only: [:new, :create]
	before_action :authorize_update!, only: [:edit, :update]
	before_action :authorize_delete!, only: :destroy


	# new action
	def new
		@ticket = Ticket.new(project_id: @project.id)
		# we need to initialize an asset for the ticket...
		@ticket.assets.build
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
		@comment = @ticket.comments.build
		# we'll use this "@states" variable to populate the selectbox
		@states = State.all
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
		# remember: a "Ticket" has_many "Assets", 
		#and each "Asset" has an uploaded file named "asset"
		# (see the "db/migrate/*_create_assets.rb" file for details)
		params.require(:ticket).permit(:title, :description, assets_attributes: [:asset])
	end

	def authorize_create!
		# "cannot?" method...ok, we need a gem called "CanCan"
		# see the Gemfile and search for "cancan"
		# then, if you want to find more details about permission management
		# see the "app/model/ability.rb" file
		if !current_user.admin? && cannot?("create tickets".to_sym,@project)
			flash[:alert] = "You cannot create tickets on this project."
			redirect_to @project
		end
	end

	# we'll implement this method in an analog way to the "authorize_create!" method
	def authorize_update!

		if !current_user.admin? && cannot?("edit tickets".to_sym, @project)
			flash[:alert] = "You cannot edit tickets on this project."
			redirect_to @project
		end
	end

	# you'll have guessed that we wrote this method...
	def authorize_delete!

		if !current_user.admin? && cannot?("delete tickets".to_sym, @project)
			flash[:alert] = "You cannot delete tickets from this project."
			redirect_to @project
		end
	end

end
