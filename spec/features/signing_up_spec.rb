require 'spec_helper'

feature "Signing up" do

	scenario "Successful sign up" do
		visit "/"
		# note that the sign up link will be in the "application.html.erb" file
		click_link "Sign up"
		fill_in "Email", with: "user@example.com"		
		fill_in "Password", with: "password"
		fill_in "Password confirmation", with: "password"
		click_button "Sign up"

		expect(page).to have_content("You have signed up successfully.")
	end
end