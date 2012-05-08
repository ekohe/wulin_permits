Rails.application.routes.draw do
  resources :users
  
  resources :user_roles
  
  resources :permissions
  
  resources :roles do
    post :update_permission, as: :member
  end
  
  resources :permissions_roles
end