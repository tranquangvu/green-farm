Rails.application.routes.draw do
  devise_for :users
  root 'landing#home'

  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :stores, only: [:create]
        get '/devices', to: 'devices#index'
      end
    end
  end

  namespace :inspecter do
    root 'base#dashboard', as: :dashboard

    resources :farms, only: [:index, :show] do
      resources :cameras, only: [:index, :show]
      resources :sensors, only: [:index]
    end
  end
end
