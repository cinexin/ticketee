require 'spec_helper'

feature "Creating Users" do 

	let!(:admin) { FactoryGirl.create(:admin_user) }

	before do
		sign_in_as!(admin)
		
		visit "/"
		click_link "Admin"
		click_link "Users"
		click_link "New User"
	end


	# Creating a new standard user scenario 
	scenario "Creating a new user" do
		
		fill_in "Email", with: "newbie@example.com"
		fill_in "Password", with: "password"
		click_button "Save"

		expect(page).to have_content("User has been created.")
	end

	# Creating a new admin user scenario
	scenario "Creating an admin user" do
		
		fill_in "Email", with: "admin@example.com"
		fill_in "Password", with: "password"
		# this is the way we can manipulate checkboxes, 
		# the argument we pass in this case is the label of the checkbox
		# see "app/views/admin/users/_form.html" for details
		check "Is an admin?"
		click_button "Save"

		expect(page).to have_content "User has been created"

    
		within("#users") do
			# how did we do that?
			# see "app/views/admin/users/index.html" file :)
			expect(page).to have_content "admin@example.com (Admin)"
		end
	end
	
end