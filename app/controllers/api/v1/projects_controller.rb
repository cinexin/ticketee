class Api::V1::ProjectsController < Api::V1::BaseController

	def index

		respond_with(Project.for(current_user))
	end

	def create
		project = Project.new (project_params)

		puts "New project passed"

		if project.save
			respond_with(project, :location => api_v1_project_path(project))
		else
			# this part just doesn't work properly :(
			puts "Save failed"
			respond_with project do |format|
				format.json {render :json,  :status=>422} 
			puts "But I pass responding "
			end
		end
	end


	private
	def project_params
		params.require(:project).permit(:name, :description)
	end
end