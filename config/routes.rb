Brokerattentive::Application.routes.draw do

  get "consolidate/index"

  # resources :users, :controller => 'users', :as => :users do
  #   # resources :roles, :controller => 'accounts/roles', :only => [:index, :update_user_roles]
  #   # resources :projects, :controller => 'accounts/projects', :only => [:index,:new,:create, :destroy]
  # end                                                                                       
  # # put 'user/:account_id/update_user_roles' => 'accounts/roles#update_user_roles', :as => :update_user_roles
  # # get 'account/change_password' => 'accounts#change_password', :as => :change_password
  # # put 'account/update_password' => 'accounts#update_password', :as => :update_password
  
  
  devise_for :users do
    get 'signout' => 'devise/sessions#destroy'
  end    
  
  resources :extract_weeklies
  resources :extract_monthlies
  resources :users
  resources :plans   
  resources :consolidates
  
  match 'feature' => 'feature#index'
  match "list_plans" => "list_plans#index"
  match 'support' => 'support#index'
  match 'about' => 'about#index'
  match 'contact' => 'contact#index'  
  match 'dashboard' => "dashboard#index"
  match 'welcome' => "welcome#index"
  match 'without_permission' => "without_permission#index"    
  match 'users' => "users#index" 
  # match 'users/:id/edit' => 'users#edit'   
  match "list_plans/:id" => "list_plans#index", :as => :list_plans_user           
  match 'import_extract_monthlies' => 'extract_monthlies#import_extract_monthlies'   
  match 'import_extract_weeklies' => 'extract_weeklies#import_extract_weeklies'   
  
  match 'select_period_consolidate' => 'consolidate#select_period_consolidate'
  match 'consolidate' => 'consolidate#consolidate'

  #users
  get 'users/:id/edit' => 'users#edit', :as => :edit_user
  get 'users/:id' => 'users#show', :as => :user
  delete 'users/:id' => 'users#destroy' 
  get 'users/change_password/:id' => 'users#change_password', :as => :change_password  
  
  put 'users/update_password' => 'users#update_password', :as => :update_password   
  put 'users/update_status/:id' => 'users#update_status', :as => :update_status   
  put 'users/update/:id' => 'users#update'   
  
  
  
  # Extract Monthly
  get 'list_extract_monthly/:period_initial/:perido_final' => 'extract_monthlies#list_extract_monthly', :as => :list_extract_monthly

  # Extract Weeklies
  get 'list_extract_weekly/:period_initial/:period_final' => 'extract_weeklies#list_extract_weekly', :as => :list_extract_weekly
  
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
