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

# the "permission" model object generation...
$ bin/rails generate model permission user_id:integer thing_id:integer thing_type:string action:string
$ bin/rake db:migrate
$ bin/rake db:test:prepare

# generate the permissions controller...
$ bin/rails generate controller admin/permissions

# generate the uploader asset...
$ bin/rails generate uploader Asset

# generate the migration to add an asset to tickets
$ bin/rails generate migration add_asset_to_tickets asset:string
# ...and as always...
$ bin/rake db:migrate
$ bin/rake db:test:prepare

# generate the "asset" model
$ bin/rails generate model asset

# generate a controller to add some protection to uploaded files
$ bin/rails generate controller files

# generate a new field in assets to store the "content type" field
# (view "app/controller/files_controller.rb" for details)
$ bin/rails generate migration add_content_type_to_assets content_type:string
# ...and as usual..
$ bin/rake db:migrate
$ bin/rake db:test:prepare

# generate the "comments" model
$ bin/rails generate model comment text:text ticket_id:integer user_id:integer
# ...and guess what's next...
$ bin/rake db:migrate
$ bin/rake db:test:prepare
# ...and the controller...
$ bin/rails generate controller comments

# generate de "state" model
$ bin/rails generate model state name:string color:string background:string
# see the "db/migrate/****_create_states.rb" migration file for some additional little hacks
# ...and...
$ bin/rake db:migrate
$ bin/rake db:test:prepare

# add the "previous_state" column to "comments" table
$ bin/rails generate migration add_previous_state_id_to_comments  previous_state_id:integer
# ...and as usual...
$ bin/rake db:migrate
$ bin/rake db:test:prepare

# generate the "states" controller...
$ bin/rails generate controller admin/states

# add the "default" column to the "states" model
$ bin/rails generate migration add_default_to_states default:boolean
# see the "db/migrate/****_add_default_to_states.rb" for a little hack
# see the "db/seeds.rb" file for viewing how we make the "New" state the default state
# ...and run...
$ bin/rake db:migrate
$ bin/rake db:test:prepare


# generate the "tags" model
# note that if we don't want to generate the default "timestamps" with the model we can do it passing --timestamps false argument
$ bin/rails generate model tag name:string --timestamps false
# before running the migration, see the "db/migrate/*****_create_tags.rb" to see how we can generate the relationship table
# ...and then...
$ bin/rake db:migrate
$ bin/rake db:test:prepare

# generate the controller for the "tag" model
$ bin/rails generate controller tags

# generate the "ticket_watchers" table 
# users are watchers of many tickets
# tickets have many watchers
$ bin/rails generate model ticket_watchers user_id:integer ticket_id:integer
# before running the migration, see the "db/migrate/*****_create_ticket_watchers.rb" for little previous hacks
$ bin/rake db:migrate
$ bin/rake db:test:prepare

# adding a token to "user" model
$ bin/rails generate migration add_token_to_users authentication_token:string
# ...and...
$ bin/rake db:migrate
$ bin/rake db:test:prepare

# ooooopss...i made a mistake with the name of the "token" column
$ bin/rails g migration FixColumnName
# see the "db/migrate/***********_fix_column_name,rb" for details
# ...and make the migration...
$ bin/rake db:migrate
$ bin/rake db:test:prepare