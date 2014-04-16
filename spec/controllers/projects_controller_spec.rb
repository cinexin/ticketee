require 'spec_helper'

describe ProjectsController do

	let(:user) {FactoryGirl.create(:user)}

	context "standard users" do

		before do
			sign_in(user)
		end

    # this code can be done with the below code (DRY!)
    # this will access the new action of projects model
    #get :new
    #expect(response).to redirect_to "/"
    #expect(flash[:alert]).to eql("You must be an admin to do that.")

    # we define a hash with all the actions and methods we want to check
    {new: :get, create: :post, edit: :get, update: :put, destroy: :delete}.each do |action, method|
      it "cannot access the #{action} action" do
        send(method, action, :id => FactoryGirl.create(:project))
        
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eql("You must be an admin to do that.")
      end  
    end
	end

	it "displays an eror for a missing project" do
		get :show, id: "not-here"

		expect(response).to redirect_to(projects_path)

		message = "The project you were looking for could not be found."
		expect(flash[:alert]).to eql(message)
	end
end
