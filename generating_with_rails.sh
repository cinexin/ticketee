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