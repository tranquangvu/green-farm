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
      post '/users/sign_in', to: 'sessions#create'
      delete '/users/sign_out', to: 'sessions#destroy'

      resources :values, only: [:create] do
        collection do
          post 'create_list'
        end
      end

      get '/devices', to: 'devices#index'
    end
  end

  namespace :inspecter do
    get '/:farm_id', to: 'base#dashboard', as: :dashboard

    resources :farms, only: [:index, :show] do
      resources :cameras, only: [:index, :show]
      resources :sensors, only: [:index]
    end
  end
end
