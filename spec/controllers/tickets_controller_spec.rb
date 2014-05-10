require 'spec_helper'

describe TicketsController do
	
	let(:user) {FactoryGirl.create(:user)}
	let(:project) {FactoryGirl.create(:project)}
	let(:ticket) {FactoryGirl.create(:ticket, project: project, user: user)}

	context "standard users" do

		it "cannot access a ticket for a project" do
			sign_in(user)
			get :show, :id => ticket.id, :project_id=>project.id

			expect(response).to redirect_to(root_path)
			msg = "The project you were looking for could not be found."
			expect(flash[:alert]).to eql(msg)
		end
	end

	context "with permission to view the project" do

		before do
			sign_in(user)
			define_permission!(user, :view, project)
		end

		def cannot_create_tickets! 
			response.should redirect_to(project)
			message = "You cannot create tickets on this project."
			flash[:alert].should eql(message)
		end

		def cannot_update_tickets!
			expect(response).to redirect_to(project)
			expect(flash[:alert]).to eql("You cannot edit tickets on this project.")
		end

		it "cannot begin to create a ticket" do

			get :new, project_id: project.id

			cannot_create_tickets!
		end

		it "cannot create a ticket without permission" do

			post :create, project_id: project.id

			cannot_create_tickets!
			
		end	

		it "cannot update a ticket without permission" do
			# if we didn't pass a ticket object (last param)
			# we would get a really strange error:
			# "NoMethodError: undefined method 'stringify keys' for nil:NilClass"
			get :edit, {project_id: project.id, id: ticket.id, ticket: {}}
			cannot_update_tickets!
		end

		it "cannot delete a ticket without permission" do

			delete :destroy, {project_id: project.id,id:ticket.id}

			expect(response).to redirect_to(project)
			msg = "You cannot delete tickets from this project."
			expect(flash[:alert]).to eql(msg)
		end

		it "can create tickets, but not tag them" do
			Permission.create(:user=>user, :thing=>project, :action=>"create tickets")
			post :create, :ticket => {:title => "New Ticket", 
									:description=> "Brand spankin' new",
									:tag_names=> "these are random tags" }, :project_id => project.id
			
			Ticket.last.tags.should be_empty
		end
	end
end