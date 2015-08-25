Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  get '/audiencia', to: 'page#audiencia'
  get '/juventud', to: 'page#juventud'
  get '/medio-ambiente', to: 'page#medio_ambiente'

  resources :inscriptions, only: [:new, :create]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'page#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
