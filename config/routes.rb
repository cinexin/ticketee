Ticketee::Application.routes.draw do
  # the line below is absolutely useless...see "generating_with_rails.sh" line 59 for details
  # get "users/index"
  
  # this way we define the root path ("/") for our project
  root "projects#index"

  # we must add the resources in our project...
  # this will provide us 7 "REST"ful actions:
  # 1. index
  # 2. show
  # 3. new
  # 4. create
  # 5. edit
  # 6. update
  # 7. destroy
  # and these actions match with this 4 request paths:
  # 1. /projects
  # 2. /projects/new
  # 3. /projects/:id
  # 4. /projects/:id/edit
  # and this is the way we match these 7 actions with these 4 paths:
  # 1. GET /projects => index
  # 2. POST /projects => create
  # 3. GET /projects/new => new
  # 4. GET /projects/:id => show
  # 5. PATCH/PUT /projects/:id => update
  # 6. DELETE /projects/:id => destroy
  # 7. GET /projects/:id/edit => edit
  # to review these routes (and more you can configure further)
  # execute this command in your console: "bin/rake routes"
  resources :projects do
    resources :tickets
  end
  
  # nested resources
  resources :tickets do
    resources :comments
  end

  resources :users

  # note the format: Prefix + Verb + Uri pattern +", to:" + Controller#Action
  # in this case, the prefix is inferred from the URL and is "signin"
  get "/signin", to:"sessions#new"
  # we need a "signin" with a post method
  post "/signin", to: "sessions#create"

  # see how we can use namespaces...
  # the command below will generate us theses routes:
  # admin_users GET    /admin/users(.:format)       admin/users#index
  #             POST   /admin/users(.:format)       admin/users#create
  # new_admin_user GET    /admin/users/new(.:format)    admin/users#new
  # edit_admin_user GET    /admin/users/:id/edit(.:format)    admin/users#edit
  # admin_user GET    /admin/users/:id(.:format)    admin/users#show
  #                  PATCH  /admin/users/:id(.:format)      admin/users#update
  #                  PUT    /admin/users/:id(.:format)      admin/users#update
  #                  DELETE /admin/users/:id(.:format)      admin/users#destroy

  namespace :admin do
    resources :users
  end

  namespace :admin do    
    # view "controllers/admin/base_controller.rb" file
    # remember: controller#action
    root :to=>"base#index"
    
    resources :users do
      resources :permissions
      # this route will only respond to "PUT" HTTP requests 
      # and it will map it to controller#action 
      # the name of the route will be the name after "as: "
      # in this case: "set_permissions"
      put "permissions", to: "permissions#set", as: "set_permissions"
    end

  end

  namespace :admin do
    resources :states
  end

  # "signout" path, similarly to the defined "set_permissions" path above ...
  delete "/signout", to: "sessions#destroy", as: "signout"

  # see the "app/controller/files_controller.rb" for details
  resources :files
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
