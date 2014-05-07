# In this spec, we'll ensure that when seed data
# is loaded, we can sign in in the app 
# as an admin with the sample admin user specified in "db/seeds.rb"

require 'spec_helper'

feature "Seed Data" do 

	scenario "The basics" do

		# this is the way we can run the task "rake db:seed"
		load Rails.root + "db/seeds.rb"

		user = User.where(email:"admin@example.com").first!
		user.password = "password"
		project = Project.where(name:"Ticketee Beta").first!

		sign_in_as!(user)
		click_link "Ticketee Beta"
		click_link "New Ticket"
		fill_in "Title", with: "Comments with state"
		fill_in "Description", with: "Comments always have a state."
		click_button "Save"

		within("#comment_state_id") do
			expect(page).to have_content("New")
			expect(page).to have_content("Open")
			expect(page).to have_content("Closed")		
		end	
	end
end

