Rails.application.routes.draw do

  resources :inscriptions, only: [:new, :create]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'page#index'

end
