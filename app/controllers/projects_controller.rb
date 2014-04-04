class ProjectsController < ApplicationController

	# the "index" action for the projects controller 
	def index

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

		end
	end

	# the "show" action for the projects
	def show
		@project = Project.find(params[:id])
	end
	
	# this is what they call "strong parameters"
	def project_params
		params.require(:project).permit(:name, :description)
	end
end
