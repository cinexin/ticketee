# The database now will be truncated after each test run
RSpec.configure do |config|
	config.before(:suite) do
		DatabaseCleaner.strategy = :truncation
		DatabaseCleaner.clean_with(:truncation)
	end
	config.before(:each) do
		DatabaseCleaner.start
	end
	config.after(:each) do
		DatabaseCleaner.clean
	end
end