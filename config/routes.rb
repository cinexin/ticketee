Ticketee::Application.routes.draw do

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
  # to review these routes execute this command in your console: "bin/rake routes"
  resources :projects
  


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
