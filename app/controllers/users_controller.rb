class UsersController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def new
		@user = User.new
	end

	def create
		@user = User.new (user_params)

		if @user.save
			flash[:notice]  = "You have signed up successfully."
			# since the projects#index action requires the user
			# to be signed_in, we need the new user to be logged in
			# at the momment he has signed up successfully
			session[:user_id] = @user.id
			redirect_to projects_path

			
			
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if (@user.update(user_params))
			flash[:notice] = "Profile has been updated."
			redirect_to user_path(@user)
		else
			flash[:alert] = "Profile has not been updated."
			render action: "edit"
		end
	end


	# private methods...
	private

	def user_params
		params.require(:user).permit(:name,:email,:password,:password_confirmation)
	end

	def set_user
		@user = User.find(params[:id])
	end
end
