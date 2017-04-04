Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  root 'projects#index'
  resources :projects
  resources :tasks
  resources :comments
end
