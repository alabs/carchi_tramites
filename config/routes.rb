Rails.application.routes.draw do

  get '/audiencia', to: 'page#audiencia'
  get '/certificado', to: 'page#certificado'
  get '/juventud', to: 'page#juventud'
  get '/medio-ambiente', to: 'page#medio_ambiente'

  resources :inscriptions, only: [:new, :create]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'page#index'

end
