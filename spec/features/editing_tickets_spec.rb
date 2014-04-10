require 'spec_helper'

feature "Editing tickets" do

	# these "let!"" methods are for creating a method with the name
	# of the argument passed to them. 
	# In this example, we can reference "project" and "ticket" anywhere in the code
	# for instance, in the "before do" statements...
	let!(:project) {
		FactoryGirl.create(:project)
	}

	let!(:ticket) {
		FactoryGirl.create(:ticket, project: project)
	}

	before do
		visit "/"
		click_link project.name
		click_link ticket.title
		click_link "Edit ticket"
	end

	scenario "Updating a ticket" do
		fill_in "Title", with: "Make it really shiny!"
		click_button "Save"

		expect(page).to have_content "Ticket has been updated."
		within ("#ticket h2") do
			expect(page).to have_content "Make it really shiny!"
		end
		expect(page).to_not have_content ticket.title
	end

	scenario "Updating a ticket with invalid information" do
		fill_in "Title", with: ""
		click_button "Save"

		expect(page).to have_content "Ticket has not been updated."
	end

end