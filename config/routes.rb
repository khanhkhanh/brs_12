Rails.application.routes.draw do
  devise_for :users

  root to: "static_pages#home"

  resources :relationships, only: [:create, :destroy]
  resources :perusals, only: [:create, :destroy]
  resources :categories, only: [:index, :show]

  resources :users, except: :destroy do
    resource :favorites, only: [:edit, :show]
  end

  resources :books, except: [:new, :create, :destroy] do
    resources :reviews, only: [:create, :destroy] do
      resources :comments, only: [:create, :destroy]
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  resources :perusals, only: [:create, :destroy]
  resources :readings, except: [:show, :new, :update]

  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
    get "/signup" => "devise/registrations#new"
    get "/edit" => "devise/registrations#edit"
  end

  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
    resources :categories
    resources :books do
      resources :reviews do
        resources :comments, only: [:create, :destroy]
      end
    end
    root to: "users#index"
  end

end
