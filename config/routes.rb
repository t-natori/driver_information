Rails.application.routes.draw do

  root to: 'maps#top'

  get '/index' => 'maps#index'

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }


  devise_for :customers, controllers: {
    sessions: 'publics/sessions',
    passwords: 'publics/passwords',
    registrations: 'publics/registrations'
  }

  namespace :admins do
    resources :customers, only: [:index, :show, :edit, :update]

    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :genres, only: [:index, :create, :edit, :update, :destroy]

  end

  scope module: :publics do
    resources :customers, only: [:show, :edit, :update]
    get 'quit' => 'customers#quit'
    patch 'out' => 'customers#out'
    resources :posts, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'publics/sessions#guest_sign_in'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
