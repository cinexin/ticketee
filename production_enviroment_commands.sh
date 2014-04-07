(project_root_path)$ bin/rake assets:precompile
(project_root_path)$ bin/rake db:migrate
(project_root_path)$ RAILS_ENV=production

# also, we will need to change the 
# config.serve_static_assets = false to true
# in the "config/environments/production.rb" file

(project_root_path)$ bin/rails server -e production