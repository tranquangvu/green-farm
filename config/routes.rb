Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'landing#home'

  resources :contacts, only: [:create] do
    collection do
      get 'thanks_you'
    end
  end

  resources :profiles, only: [:show, :edit, :update]

  namespace :api do
    namespace :v1 do
      post    'users/sign_in',       to: 'sessions#create'
      delete  'users/sign_out',      to: 'sessions#destroy'
      post    'values',              to: 'values#create'
      post    'values/create_list',  to: 'values#create_list'
      get     'devices',             to: 'devices#index'
      get     'profile',             to: 'profiles#show'
      put     'profile',             to: 'profiles#update'
      patch   'profile',             to: 'profiles#update'

      resources :farms, only: [:index, :show] do
        member do
          get 'sensor_data'
          get 'pictures'
          post 'upload_picture'
        end
      end
      resources :cameras, only: [] do
        member do
          post 'up'
          post 'down'
          post 'left'
          post 'right'
        end
      end
    end
  end

  namespace :inspecter do
    get '/:id', to: 'base#dashboard', as: :dashboard

    scope :values do
      get 'temperature_of_date',   to: 'values#temperature_of_date'
      get 'humidity_of_date',      to: 'values#humidity_of_date'
      get 'soil_moisture_of_date', to: 'values#soil_moisture_of_date'
      get 'light_of_date',         to: 'values#light_of_date'

      get 'temperature_of_month',   to: 'values#temperature_of_month'
      get 'humidity_of_month',      to: 'values#humidity_of_month'
      get 'soil_moisture_of_month', to: 'values#soil_moisture_of_month'
      get 'light_of_month',         to: 'values#light_of_month'
    end

    resources :farms, only: [:index, :show, :update] do
      member do
        get 'report'
        get 'chart'
        get 'settings'
        get 'gallery'
      end
      resources :cameras, only: [:show] do
        member do
          post 'snapshot'
          post 'up'
          post 'down'
          post 'left'
          post 'right'
        end
      end
      resources :notifications, only: [:index] do
        member do
          post 'seen'
        end

        collection do
          post 'mark_all_seen'
        end
      end
    end
  end
end
