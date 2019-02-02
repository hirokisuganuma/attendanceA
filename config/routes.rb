Rails.application.routes.draw do
  
  root                'static_pages#home'
  get    'help'    => 'static_pages#help'
  get    'about'   => 'static_pages#about'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  get    'users/:id/edit_basic_info',to:'users#edit_basic_info',as:'edit_basic_info'
  patch  'users/:id/update_basic_info' , to: 'users#update_basic_info',as:'update_basic_info'
  post   'works/:id', to: 'works#edit_works',as:'edit_works'
  get    'base_edit_modal',to: 'bases#base_edit_modal',as:'base_edit_modal'
  post    'delete_base',to: 'bases#destroy',as:'delete_base'
  get    '/users/working_users'
  get    'users/:id'    => 'works#show'
  resources :bases do
     
    end
  resources :works
  # resources :worksがあるので修正はいらなかったですね。そのままコントローラーのアクションcreateの追加とビューの名前変更で行けると思います！
  resources :users do
    
  end
  
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
end