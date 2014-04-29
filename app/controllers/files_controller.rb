# see also "spec/controllers/files_controller_spec.rb"
# for more info about this "strange" controller
class FilesController < ApplicationController

	before_action :require_signin!

	def show

		asset = Asset.find(params[:id])
		# the first argument of the "send_file"
		# method is the path to the file you're sending
		# the second argument is an options hash used to pass in the filename and content_type
		# so the browser receiving the file knows what to call it and the file type
		if can?(:view, asset.ticket.project)
			send_file asset.asset.path,	filename: asset.asset_identifier, content_type: asset.content_type
		else
			flash[:alert] = "The asset you were looking for could not be found."
			redirect_to root_path
		end

	end
end
