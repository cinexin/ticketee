require 'spec_helper'

describe Admin::UsersController do

	let(:user) {FactoryGirl.create(:user)}

	# context for standard signed in users
	context "standard users" do
		# the "sign_in" method is in: "spec/helpers/support/authentication_helpers.rb"
		before {sign_in(user)}

		# we don't want the standard users to access the index action
		it "are not able to access the index action" do
			get "index"
			expect(response).to redirect_to "/"
			expect(flash[:alert]).to eql("You must be an admin to do that.")
		end
	end
end
