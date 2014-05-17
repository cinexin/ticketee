class Api::V1::BaseController < ActionController::Base

	# this sets to any inheriting controller to respond to JSON & XML requests
	respond_to :json, :xml

	# before concerns
	before_action :authenticate_user


	private 

	def authenticate_user
		@current_user = User.find_by_token(params[:token])
		unless @current_user
			respond_with({:error=>"Token is invalid."})
		end
	end

	def current_user
		@current_user
	end



end