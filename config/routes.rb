Rails.application.routes.draw do
  root 'shop#home'

  get 'auth', to: 'auth#index'
  post 'auth', to: 'auth#sign_in', as: :sign_in
  get 'auth/sign_out', as: :sign_out

  resources :customers, only: [:new, :create, :update]
  get 'settings', to: 'customers#edit'
#   put 'customers', to: 'customers#update', as: :save_settings

  resources :books, only: [:show] do
    resources :reviews, only: [:new, :create]
  end

  get 'home', to: 'shop#home'
  get 'shop', to: 'shop#index'
  get 'shop_by_ctg', to: 'shop#by_category'
  
  get '/404', to: 'application#page_404'

  resources :orders, only: [:update ,:index, :show]
  get 'cart', to: 'orders#edit'
  post 'empty_cart/:id', to: 'orders#empty_cart'
  post 'orders', to: 'orders#new_item', as: :new_order_item
  get 'cart/checkout/address', to: 'orders#checkout_address', as: :checkout_address
  patch 'cart/checkout/address', to: 'orders#save_cart_address', as: :save_cart_address
  get 'cart/checkout/delivery', to: 'orders#checkout_delivery', as: :checkout_delivery
  patch 'cart/checkout/delivery', to: 'orders#save_cart_delivery', as: :save_cart_delivery
  get 'cart/checkout/payment', to: 'orders#checkout_payment', as: :checkout_payment
  patch 'cart/checkout/payment', to: 'orders#save_cart_payment', as: :save_cart_payment
  get 'cart/checkout/confirm', to: 'orders#checkout_confirm', as: :checkout_confirm
  patch 'cart/checkout/complete', to: 'orders#checkout_complete', as: :checkout_complete

  # post 'customers/test_action', to: 'customers#test_action'

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
