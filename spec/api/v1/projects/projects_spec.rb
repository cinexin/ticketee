require 'spec_helper'

describe "api/v1/projects", :type=>:api do

	let!(:user) {FactoryGirl.create(:user)}
	let!(:token) {user.token}
	let!(:project) {FactoryGirl.create(:project)}

	before do
		user.permissions.create!(:action=>"view", :thing=>project)
	end

	context "projects viewable by this user" do

		before do
			FactoryGirl.create(:project, :name=>"Access denied")
		end


		let(:url) {"/api/v1/projects"}
		
		it "json" do
			# this "get" method is provided by Rack::Test::Methods module
			get "#{url}.json", :token => token
			projects_json = Project.for(user).to_json

			response.body.should eql(projects_json)
			response.status.should eql(200)

			# this "JSON.parse" goodie is provided by the json gem
			# it converts a JSON string and converts it into a
			# Ruby array or hash
			projects = JSON.parse(response.body)
			projects.any? do |p|
				p["name"] == project.name
			end.should be_true

			projects.any? do |p|
				p["name"] == "Access denied"
			end.should be_false
		end
	end
end