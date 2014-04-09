require 'spec_helper'

feature "Creating Tickets" do

	before do
		FactoryGirl.create(:project, name: "Internet Explorer")

		visit "/"
		click_link "Internet Explorer"
		click_link "New Ticket"
	end

	scenario "Creating a ticket" do
		fill_in "Title", with: "Non-standars compliance"
		fill_in "Description", with: "My pages are...MINE!"
		click_button "Save"

		expect(page).to have_content "Ticket has been created."

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