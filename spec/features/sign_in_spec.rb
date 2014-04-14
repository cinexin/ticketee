require 'spec_helper'

feature "signin in." do 

	scenario "Signing in via form" do

		user = FactoryGirl.create(:user)

		# A good place to put this link is the application.html.erb layout
		visit "/"
		click_link "Sign in"

		fill_in "Name", with: user.name
		fill_in "Password", with: user.password
		click_button "Sign in"

		expect(page).to have_content("Signed in successfully.")
	end
end