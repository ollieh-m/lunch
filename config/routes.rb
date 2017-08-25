Rails.application.routes.draw do

  root to: 'dashboard#show'

  resource :message_action, only: [:create]

  resource :slack_authentication, only: [:show] do
    collection do
      get 'callback'
    end
  end

  resources :menus, only: [:index, :new, :create] do
    collection do
      post 'distribute'
    end
  end

  namespace :api do
    scope module: :v1 do
      resource :bantaclause, only: [:create]
    end
  end

end
