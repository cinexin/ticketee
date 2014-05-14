# here we define a module calle ApiHelper
# this module will be included into any test marked as API (with the :type option)


module ApiHelper 
	# this will provide us useful methods for making requests to our app
	include Rack::Test::Methods

	def app
		Rails.application
	end
end


RSpec.configure do |c|
	c.include ApiHelper, type: :api
end


