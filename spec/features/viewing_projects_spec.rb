require 'spec_helper'

# NOTE: the name of these files must end with "_spec"

feature "Viewing projects" do 

	let!(:user) {FactoryGirl.create(:user)}
	let!(:project) {FactoryGirl.create(:project)}

	before do

		sign_in_as!(user)
		# the define_permission method defines a permission record
		# it's responsible for giving user access to the specified object
		# view "spec/support/authorization_helpers.rb" for viewing the implementation
		define_permission!(user,:view, project)

	end

	scenario "Listing all projects" do

		# we don't want the user to view the projects he doesn't have permission
		FactoryGirl.create(:project, name: "Hidden")
		visit '/'
		expect(page).to_not have_content("Hidden")

		click_link project.name

		expect(page.current_url).to eql(project_url(project))
	end
	
end