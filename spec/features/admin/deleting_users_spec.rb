require 'spec_helper'

feature 'Deleting users' do	

	let!(:admin_user) {FactoryGirl.create(:admin_user)}
	let!(:user) {FactoryGirl.create(:user)}

	before do
		# view "spec/features/support/authentication_helpers.rb"
		sign_in_as!(admin_user)
		visit "/"
		click_link "Admin"
		click_link "Users"
	end

	scenario "Deleting a user" do

		click_link user.email
		click_link "Delete User"

		expect(page).to have_content "User has been deleted"
	end

	# we must check a user won't be able to delete himself
	scenario "A user cannot delete himself" do

		click_link admin_user.email
		click_link "Delete User"

		expect(page).to have_content "You cannot delete yourself"
	end
end