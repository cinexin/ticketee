$ rails new ticketee

$ (view "installing_the_gems_defined_in_gemfile.sh")

(app_root_path) $ bin/rails generate rspec:install

# this will generate two stubs in ./bin path: "autospec" and "rspec", that whill allow us to call them directly
(app_root_path) $ bin/bundle binstubs rspec-core