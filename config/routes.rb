Rails.application.routes.draw do
  resources :users do
    collection do
      post :invite
    end
  end

  resources :roles_users

  resources :permissions

  resources :roles do
    post :update_permission, as: :member
  end

  resources :permissions_roles
end