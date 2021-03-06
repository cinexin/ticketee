require 'spec_helper'

feature 'Creating Projects'  do

	# we define a 'before' action to avoid repeating code...
	before do
		# see the user_factory.rb to see how "admin_user" it's defined
		sign_in_as!(FactoryGirl.create(:admin_user))
		visit "/"
		click_link 'New Project'		
	end

	scenario "can create a project" do
	
		# we don't want to repeat these two lines everywhere...see the "before do" in this file
		#visit "/"
		#click_link 'New Project'	

		# we can put here the name of the corresponding label
		# or the id attribute
		# or the name attribute
		fill_in "Name", with: "TextMate 2"
		fill_in "Description", with: "A text-editor for OS X"
		
		click_button "Save"
		expect(page).to have_content("Project has been created.")

		project = Project.where(name: "TextMate 2").first

		expect(page.current_url).to eql(project_url(project))

		title = "TextMate 2 - Projects - Ticketee"
		expect(page).to have_title(title)
	end

	# scenario with validations
	scenario "can't create a project without a name" do
		# we don't want to repeat these two lines everywhere...see the "before do" in this file
		#visit "/"
		#click_link 'New Project'	


		click_button "Save"
		expect(page).to have_content("Project has not been created.")
		expect(page).to have_content("Name can't be blank")
	end


end