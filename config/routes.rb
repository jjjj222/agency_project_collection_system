Rails.application.routes.draw do
  #get 'sessions/new'

  get       'my_login'  => 'sessions#new'
  get       'tamu_login'  => 'sessions#tamu_new'
  get       'my_logout'    => 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #resource :mypage
  get       'mypage'    => 'mypage#index'

  # get 'tamu_users/index'

  get 'welcome/index'
  #get 'welcome/login'
  #get 'welcome/signup'

  # get 'tamu_users/my_page'
  #get 'tamu_users/my_page/projects'

  match '/unapproved_projects/' => 'projects#unapproved_index', :as => :unapproved_projects_index, via: [:get]
  match '/projects/:id/approve' => 'projects#approve', :as => :approve_project, via: [:post]
  match '/projects/:id/unapprove' => 'projects#unapprove', :as => :unapprove_project, via: [:post]
  resources :projects  # The priority is based upon order of creation: first created -> highest priority.
  
  resources :tamu_users
  # See how all your routes lay out with "rake routes".

  match '/unapproved_agencies/' => 'agencies#unapproved_index', :as => :unapproved_agencies_index, via: [:get]
  match '/agencies/:id/approve' => 'agencies#approve', :as => :approve_agency, via: [:post]
  match '/agencies/:id/unapprove' => 'agencies#unapprove', :as => :unapprove_agency, via: [:post]
  resources :agencies

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
