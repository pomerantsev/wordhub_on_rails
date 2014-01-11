WhRails::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  
  post "attempt_login", to: "access#attempt_login"
  get "logout", to: "access#logout"
  get "intro", to: "static_pages#intro"
  get "about", to: "static_pages#about"

  get "signup", to: "users#new"
  get "settings", to: "users#edit"

  get "stats", to: "users#show"

  # Sample of named route:
  #   get 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  
  resources :users, only: [:new, :create, :show, :edit, :update]

  resources :flashcards, except: :show do
    collection { patch :undelete }
  end
  
  resources :repetitions, only: [:index, :update]

  scope '/api' do
    post 'login', to: 'access#attempt_login'
    delete 'logout', to: 'access#logout'
    get 'session', to: 'access#check_session'
    get 'xsrf-token', to: 'application#xsrf_token'
    resources :flashcards, only: [:index, :show, :create, :update, :destroy] do
      collection { patch :undelete }
    end
    resources :repetitions, only: [:index, :update]
  end

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
  root to: 'application#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # get ':controller(/:action(/:id))(.:format)'
end
