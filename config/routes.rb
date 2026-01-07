Rails.application.routes.draw do
  resources :users
  resources :roles_users
  resources :permissions

  resources :roles do
    post :update_permission, as: :member
  end

  get "privileges/export_privilege_permission", to: "privileges#export_privilege_permission"
  post "privileges/import_privilege_permission", to: "privileges#import_privilege_permission"

  resources :permissions_roles
  resources :privileges
  resources :roles_privileges
  resources :permissions_privileges
  resources :users_privileges
  resources :user_all_permissions
  resources :permission_all_users
end
