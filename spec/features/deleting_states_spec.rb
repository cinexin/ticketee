require 'spec_helper'

feature "Deleting states" do 


	let!(:state) {FactoryGirl.create(:state)}
	let!(:admin_user) {FactoryGirl.create(:admin_user)}

	before do
		sign_in_as!(admin_user)
		visit "/"
		click_link "Admin"
		click_link "States"
		click_link state.name
	end

	scenario "Deleting a state" do
		click_link "Delete State"

		expect(page).to have_content "State has been deleted."
		expect(page).to have_no_content state.name
	end

	
end