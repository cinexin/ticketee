# this way we generate the controller for "projects" resource
# it also generates the helpers and the assets
# note that we use the pluralized form for the "project" model,
# "projects_controller will deal with multiple project(s)""

# this also generates "spec/controllers/projects_controller_spec.rb"
$ bin/rails generate controller projects

# generating project model (the default type is string, so we don't have to specify them)
$ bin/rails generate model project name description
# but if we wanted to specify them explicitally, you can run this:
$ bin/rails generate model prohect name:string description:string

# run the migrations:
$ bin/rake db:migrate
# undo a migration:
$ bin/rake db:rollback


$ bin/rails generate controller tickets
$ bin/rails generate model ticket title:string description:text project:references

# to view the model generated by this command, see the file "db/schema.rb"
$ bin/rake db:migrate
# the test database
$ bin/rake db:test:prepare
# with large migrations, it's best to use the following command
$ bin/rake db:schema:load


# this is the way we generate the user model to login, authenticate, security and so
$ bin/rails generate model user name:string email:string password_digest:string
$ bin/rake db:migrate db:test:prepare

# we can generate the users controller with some actions too!
# NOTE: be careful with this, because you can also generate stuff you don't want
$ bin/rails generate controller users new create show

# this is the way we can alter a table in the database
$ bin/rails generate migration add_user_id_to_tickets user:references
$ bin/rake db:migrate
$ bin/rake db:test:prepare

# another example of adding a field to a table in the database
$ bin/rails generate migration add_admin_to_users admin:boolean
# ...and as usual, migrate de development and test databases...
$ bin/rake db:migrate
$ bin/rake db:test:prepare

# we generate a "namespaced controller" to add the funcionality 
# to grant admin privileges to users
# the controller will be "Admin::UsersController" at app/controllers/admin/users_controller.rb
#  the views of this controller will be under app/views/admin/users
# and the spec will be at spec/controllers/admin/users_controller_spec.rb 
# additionally, note that this controller will contain an index action and 
# will generate an "index.html.erb" file under app/views/admin/users/
# finally, this will generate us a BAD entry (better said, useless) in config/routes.rb
# get "users/index"...we can remove it
$ bin/rails generate controller admin/users index