Rails.application.routes.draw do

  root to: 'maps#top'

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

    resources :posts, only: [:index, :show, :destroy]
      resources :commentss, only: [:destroy]

    resources :genres, only: [:index, :create, :edit, :update]
  end

  scope module: :publics do
    resources :cusstomers, only: [:show, :edit, :update]
    resources :posts, only: [:new, :create, :index, :show, :destroy, :edit, :update]
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
