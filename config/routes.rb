Rails.application.routes.draw do
  devise_for :users
  devise_for :admin
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'public/homes#top'
  scope module: :public do
    resources :groups, only: [:new, :create, :index, :show] do
      resources :memberships, only: [:create, :destroy]
      resources :expenses, only: [:create]
    end
  end
end
