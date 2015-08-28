Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  get '/audiencia', to: 'page#audiencia'
  get '/juventud', to: 'page#juventud'
  get '/medio-ambiente', to: 'page#medio_ambiente'

  get 'solicitar/:event_id', to: 'inscriptions#new', as: "new_inscription"
  resources :inscriptions, path: 'solicitar', only: [:create]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'page#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
