Rails.application.routes.draw do
  devise_for :users
  devise_for :admin
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'public/homes#top'
  resources :expenses, only: [:post]
end
