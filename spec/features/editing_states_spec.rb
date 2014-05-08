require 'spec_helper'

feature "Editing States" do
	
	let!(:state) {FactoryGirl.create(:state)}

	before do 
		sign_in_as!(FactoryGirl.create(:admin_user))

		visit "/"
		click_link "Admin"
		click_link "States"
		click_link state.name
		click_link "Edit State"
	end

	scenario "Editing a state" do
		# for now, we'll only update the name
		fill_in "Name", :with => "Duplication"
		click_button "Save"

		expect(page).to have_content "State has been updated."
		expect(page).to have_content "Duplication"
	end

end