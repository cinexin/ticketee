module AuthenticationHelpers

  def sign_in_as!(user)
  
		visit "/signin"
		fill_in "Name", with: user.name
		fill_in "Password", with: user.password
		click_button "Sign in"

		expect(page).to have_content("Signed in successfully.")
	end

  
end

# this includes this module into all specs in the "specs/features" directory
RSpec.configure do |c|
	c.include AuthenticationHelpers, type: :feature
end

# module for "sign_in" method
module AuthHelpers
  
  def sign_in(user)
    session[:user_id] = user.id
  end
  
end

RSpec.configure do |c|
  c.include AuthHelpers, type: :controller
end

# module for "define_permission!" method
module AuthorizationHelpers

	def define_permission!(user, action, thing)

		# the "permission" model is used for tracking wich users can do
		# wich action on a certain thing
		# view "generating_with_rails.sh" to view how we define this peculiar model object
		Permission.create(user: user, action: action, thing: thing)
	end
end

RSpec.configure do |c|
	c.include AuthorizationHelpers
end