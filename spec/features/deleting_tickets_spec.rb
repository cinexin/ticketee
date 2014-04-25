require 'spec_helper'

feature "Deleting tickets" do

	# see editing_tickets_spec.rb for an explanation of these "strange" methods...
	let!(:project) {
		FactoryGirl.create(:project)
	}

	let!(:user) {
		FactoryGirl.create(:user)
	}

	let!(:ticket) {
		ticket = FactoryGirl.create(:ticket, project: project)
		ticket.update(user: user)
		ticket
		# you can sum up the above statements in just one...
		# ticket = FactoryGirl.create(:ticket, project: project, user: user)
	}

	before do
		# this method is defined in "spec/support/authentication_helpers.rb"
		sign_in_as!(user)
		define_permission!(user,:view, project)
		visit "/"
		click_link project.name
		click_link ticket.title
	end

	scenario "Deleting a ticket" do
		click_link "Delete Ticket"

		expect(page).to have_content("Ticket has been deleted.")
		expect(page.current_url).to eq(project_url(project))
	end

end