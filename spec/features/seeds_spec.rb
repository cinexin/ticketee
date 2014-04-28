# In this spec, we'll ensure that when seed data
# is loaded, we can sign in in the app 
# as an admin with the sample admin user specified in "db/seeds.rb"

require 'spec_helper'

feature "Seed Data" do 

	scenario "The basics" do

		# this is the way we can run the task "rake db:seed"
		load Rails.root + "db/seeds.rb"

		user = User.where(email:"admin@example.com").first!
		project = Project.where(name:"Ticketee Beta").first!
	end	

	
end

