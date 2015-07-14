Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'account_activations/edit'
  
  get 'sessions/new'

  root             'static_pages#home' # Controller#Action <!--get 'static_pages/home'-->
  get    'help'    => 'static_pages#help' #'static_pages/help'
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post    'login'  => 'sessions#create'
  delete  'logout' => 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  
  
  
  resources :optional_admin
  
  get 'admin_tools'             =>'admin_power#list'
  get 'admin_tools/user'        =>'admin_power#edit'
  get 'admin_tools/makeAdmin'   =>'admin_power#makeAdmin'
  get 'admin_tools/delAdmin'    =>'admin_power#delAdmin'
  get 'admin_tools/cleanup'     =>'admin_power#cleanup'

end
