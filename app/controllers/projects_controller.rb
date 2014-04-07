class ProjectsController < ApplicationController

	before_action :set_project, only: [:show, :edit, :update, :destroy]

	# the "index" action for the projects controller 
	def index
		@projects = Project.all
	end

	# the "new" action for the projects controller
	def new
		@project = Project.new
	end

	# the "create" action por the projects
	def create
		@project= Project.new(project_params)

		if @project.save
			flash[:notice] = "Project has been created."

			# this will redirect us to project_path(@project)
			redirect_to @project
		else
			# we give an alert message to the user
			flash[:alert] = "Project has not been created."
			# when we "render" a page, we must supply the "name" of the "name.html.erb"
			render "new"

		end
	end

	# the "show" action for the projects
	def show
		# this line isn't necessary anymore (view "set_project" method at the end)
		# @project = Project.find(params[:id])
	end

	# the "edit" action for the projects
	def edit
		# this line isn't necessary anymore (view "set_project" method at the end)
		#@project = Project.find(params[:id])
	end

	# the "update" action for the projects
	def update 
		# this line isn't necessary anymore (view "set_project" method at the end)
		#@project = Project.find(params[:id])

		if @project.update(project_params)
			flash[:notice] = "Project has been updated."
		else
			flash[:alert] = "Project has not been udpated."
			redirect_to edit_project_path(@project)
			return
		end

		redirect_to @project
	end
	
	# method for deleting projects
	def destroy
		# this line isn't necessary anymore (view "set_project" method at the end)
		# @project = Project.find(params[:id])
		@project.destroy
		flash[:notice] = "Project has been destroyed."
		redirect_to projects_path
	end

	private
	# this is what they call "strong parameters"
	def project_params
		params.require(:project).permit(:name, :description)
	end

	def set_project
		@project = Project.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		flash[:alert] = "The project you were looking for could not be found."
		redirect_to projects_path
	end
end
