Rails.application.routes.draw do
  resources :inscriptions
  root 'page#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
