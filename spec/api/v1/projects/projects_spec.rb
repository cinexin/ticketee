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
		
		# for JSON requests
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

		# for XML requests
		it "XML" do
			get "#{url}.xml", :token=>token
			response.body.should eql(Project.for(user).to_xml)

			# Nokogiri is a gem used to parse XML and HTML documents
			projects = Nokogiri::XML(response.body)
			projects.css("project name").text.should eql(project.name)
		end
	end

	context "Creating a project" do

		let(:url) {"/api/v1/projects"}

		# successful creation via JSON request
		it "successful JSON" do
			post "#{url}.json", :token=>token, :project=>{:name=>"Inspector"}

			project = Project.find_by_name!("Inspector")
			route = "/api/v1/projects/#{project.id}"
			
			# 210 is the http status that means "correct creation"
			response.status.should eql(201)
			response.headers["Location"].should eql(route)
			response.body.should eql(project.to_json)
		end

=begin
		it "unsuccessful JSON"  do
			post "#{url}.json", :token=>token, :project=>{:description=>"blabla"}

			response.status.should eql(201)
			errors = {"errors" => {"name" => ["can't be blank"]}}.to_json
			response.should eql(errors)
		end 
=end

	end
end