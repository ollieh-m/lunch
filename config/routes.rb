Rails.application.routes.draw do

  root to: 'dashboard#show'

  resource :slack_authentication, only: [:show] do
    collection do
      get 'callback'
    end
  end

  resources :menus, only: [:index, :new, :create]

  resources :menu_blocs, only: [:create]

  namespace :api do
    scope module: :v1 do
      resource :message_action, only: [:create]
    end
  end

end
