Rails.application.routes.draw do
  root 'landing#home'

  namespace :inspecter do
    root 'base#dashboard'
    
    resources :farms, only: [:index]
    resources :cameras, only: [:index]
    resources :sensors, only: [:index]
  end
end
