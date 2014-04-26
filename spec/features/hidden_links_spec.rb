# This file will define the specifications for
# hiding links that some users won't be able to perform
# such as a create project action if you're not an admin user

require 'spec_helper'

feature "hidden links" do
  
  # review the "editing_tickets_spec.rb" file to view the explanation of these "let"
  let(:user) {FactoryGirl.create(:user)}
  let(:admin) {FactoryGirl.create(:admin_user)}
  let(:project) {FactoryGirl.create(:project)}
  let(:ticket) { FactoryGirl.create(:ticket, project: project,user: user) }  
  
  # you will see below some "assert_link" and "assert_no_link" methods
  # they're declared in "spec/support/capybara_helpers.rb"
  
  context "anonymous users" do
    scenario "cannot see the New Project link" do
    
      visit "/"
      assert_no_link_for "New Project"
    end

    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end

  end
  
  context "regular users" do
    before {sign_in_as!(user)}
    
    scenario "cannot see the New Project link" do
      
      visit "/"
      assert_no_link_for "New Project"
    end

    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end

    scenario "New ticket link is shown to a user with permission" do
      
      define_permission!(user,:view,project)
      define_permission!(user, "create tickets".to_sym, project)

      visit project_path(project)
      assert_link_for "New Ticket"
    end

    scenario "New ticket link is hidden from a user without permission" do
      
      define_permission!(user, :view, project)

      assert_no_link_for "New Ticket"
    end

    scenario "Edit ticket link is shown to a user with permission" do

      # note that we need to create the ticket first 
      # otherwise there will never be a ticket link 
      ticket

      define_permission!(user,"view", project)
      define_permission!(user, "edit tickets", project)

      visit project_path(project)
      click_link ticket.title

      assert_link_for "Edit Ticket"

    end

    scenario "Edit ticket link is hidden from a user without permission" do

      # note that we need to create the ticket first 
      # otherwise there will never be a ticket link 
      ticket

      define_permission!(user,"view", project)

      visit project_path(project)
      click_link ticket.title

      assert_no_link_for "Edit Ticket"

    end

    scenario "Delete ticket link is shown to user with permission to do that" do

      # note that we need to create the ticket first 
      # otherwise there will never be a ticket link 
      ticket
      
      define_permission!(user, "view", project)      
      define_permission!(user, "delete tickets", project)

      visit project_path(project)

      click_link ticket.title

      assert_link_for "Delete Ticket"
    end

    scenario "Delete ticket link is hidden from user with permission to do that" do

      # note that we need to create the ticket first 
      # otherwise there will never be a ticket link 
      ticket
      
      define_permission!(user, "view", project)      


      visit project_path(project)

      click_link ticket.title

      assert_no_link_for "Delete Ticket"
    end


  end
  
  context "admin users" do
    before {sign_in_as!(admin)}
    
    scenario "can see the New Project link" do
      
      visit "/"
      assert_link_for "New Project"
    end  
    
    scenario "can see the Edit Project link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end

    scenario "can see the Delete Project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end

    scenario "New ticket link is shown to admins" do
      visit project_path(project)
      assert_link_for "New Ticket"
    end

    scenario "Edit ticket link is shown to admins" do
      # note that we need to create the ticket first 
      # otherwise there will never be a ticket link 
      ticket

      visit project_path(project)
      click_link ticket.title

      assert_link_for "Edit Ticket"
    end

    scenario "Delete ticket link is shown to admins" do
      # note that we need to create the ticket first 
      # otherwise there will never be a ticket link 
      ticket

      visit project_path(project)
      click_link ticket.title

      assert_link_for "Delete Ticket"
    end
  end
  
end
