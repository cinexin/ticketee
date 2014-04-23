class Admin::BaseController < ApplicationController
	# we want to run the authorize_admin! method before every action
	# in the UsersController class (see that the UsersController class inherits from me)
	# for details of authorize_admin! see the "application_controller.rb" file
	before_action :authorize_admin!

	def index
		# simply it will go to "app/views/admin/base/index.html.erb"
	end
end