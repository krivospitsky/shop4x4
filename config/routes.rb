Shop::Application.routes.draw do
  devise_for :users

  mount Ckeditor::Engine => '/ckeditor'

  resources :pages#, as: :original_page
  resources :promotions
#  resources :categories
#  resources :products

  get 'catalog/search' => 'products#search'
  get 'catalog(/*category_path)/:category_id/product/:id', to: 'products#show', as: :original_product
  #get 'catalog(/*category_path)/:category_id/product/:id', to: 'products#show', as: :original_product
  get 'catalog(/*category_path)/:category_id/', to: 'products#index', as: :category
  get 'catalog', to: 'products#index'
#  resources :main

 # get 'login' => 'auth#index'
#  get '/cart', to: 'orders#new', as: '/cart'
  resources :cart_items
  get '/cart/delete/:product_id' => 'cart#delete'
  post '/cart/add' => 'cart#add'
  resources :orders

    # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
#  root 'pages#show', id: Page.first.id
#  root 'products#index'
  root 'main#show'

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
  devise_for :admins

  namespace :admin do
    resources :products do
      get :autocomplete, :on => :collection
    end
    resources :categories do
      get :autocomplete, :on => :collection
    end
    resources :pages
    resources :promotions
    get '/settings/edit' => '/admin/settings#edit'
    post '/settings/edit' => '/admin/settings#update'
    get '/moscanella/new' => '/admin/moscanella#new'
    post '/moscanella/import' => '/admin/moscanella#import'
  end
end
