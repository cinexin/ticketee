source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# note we have three scenarios: "test", "development", "production"

group :test, :development do
	gem 'rspec-rails',"~>2.14"
end

# this is a navigator simulator, which is used for testing "if you press this link, you will be redirected to..."
# among lots of other things
group :test do
	gem 'capybara', "2.2.1"
	gem 'factory_girl_rails', '~>4.2.1'
	gem 'email_spec', '~> 1.5.0'
end

# the "cancan" gem brings us a set of helpers
# to manage permissions
gem 'cancan', '~>1.6.10'

# the "CarrierWave" gem brings us the functionality
# to upload files from our web app
gem 'carrierwave', '0.9.0'
# note: to automatically require this gems, view the "config/application.rb" file (line 9)

# see "spec/spec_helper.rb" for details about this gem (search for "config.use_transactional_fixtures")
# to configure this gem, we need to create a new file at 'spec/support/database_cleaning.rb', see it for more details
gem 'database_cleaner', '1.0.1'

gem 'selenium-webdriver' , '~> 2.41.0'


gem 'email_spec', '~> 1.5.0'
