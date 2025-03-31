Rails.application.routes.draw do

devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'public/homes#top'
  scope module: :public do
    resources :groups, only: [:new, :create, :index, :show, :destroy] do
      resources :memberships, only: [:create, :destroy]
      resources :expenses, only: [:create, :destroy] do
        collection do
          delete :reset_all
        end
      end
    end
  end
end
