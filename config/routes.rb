Rails.application.routes.draw do
  root to: 'maps#top'
  devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
