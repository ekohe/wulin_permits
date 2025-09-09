Rails.application.routes.draw do
  resources :users

  resources :roles_users

  resources :permissions

  get "roles/export_role_permission", to: "roles#export_role_permission"
  post "roles/import_role_permission", to: "roles#import_role_permission"

  resources :roles do
    post :update_permission, as: :member
  end

  resources :permissions_roles
end