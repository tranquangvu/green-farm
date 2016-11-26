Rails.application.routes.draw do
  devise_for :users

  root 'landing#home'

  resources :contacts, only: [:create] do
    collection do
      get 'thanks_you'
    end
  end

  resources :profiles, only: [:show, :edit, :update]

  namespace :api do
    namespace :v1 do
      post    '/users/sign_in',       to: 'sessions#create'
      delete  '/users/sign_out',      to: 'sessions#destroy'
      post    '/values',              to: 'values#create'
      post    '/values/create_list',  to: 'values#create_list'
      get     '/devices',             to: 'devices#index'
      get     '/profile',             to: 'profiles#show'
      put     '/profile',             to: 'profiles#update'
      patch   '/profile',             to: 'profiles#update'

      resources :farms, only: [:index, :show] do
        member do
          get 'sensor_data'
        end
      end
    end
  end

  namespace :inspecter do
    get '/:farm_id', to: 'base#dashboard', as: :dashboard

    resources :farms, only: [:index, :show] do
      member do
        get 'report'
      end
      resources :cameras, only: [:index, :show]
    end
  end
end
