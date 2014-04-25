require 'spec_helper'

feature "Creating Tickets" do

	before do
		project = FactoryGirl.create(:project, name: "Internet Explorer")
		user = FactoryGirl.create(:user)
		define_permission!(user,:view, project)
		@email = user.email
		sign_in_as!(user)
		visit "/"

		# this is no longer correct since we have signed up in line 10
		#message = "You need to sign in or sign up before continuing."
		#expect(page).to have_content(message)
		#fill_in "Name", with: user.name
		#fill_in "Password", with: user.password
		#click_button "Sign in"
		click_link project.name
		click_link "New Ticket"

	end

	scenario "Creating a ticket" do
		fill_in "Title", with: "Non-standars compliance"
		fill_in "Description", with: "My pages are...MINE!"
		click_button "Save"

		expect(page).to have_content "Ticket has been created."

		within "#ticket #author" do
			expect(page).to have_content("Created by #{@email}")
		end	
	end

	scenario "Creating a ticket without valid attributes fails" do
		click_button "Save"

		expect(page).to have_content "Ticket has not been created."
		expect(page).to have_content "Title can't be blank"
		expect(page).to have_content "Description can't be blank"
	end

	scenario "Creating a ticket with description length < 10 characters" do
		fill_in "Title", with: "Non-standars compliance"
		fill_in "Description", with: "i'm 11!"
		click_button "Save"

		expect(page).to have_content "Ticket has not been created."
		expect(page).to have_content "Description is too short"
	end

end