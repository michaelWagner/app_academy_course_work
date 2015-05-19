Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :bands

  resources :bands, only: [] do
    resources :albums, only: [:new]
  end
  resources :albums, except: [:new, :index]

  resources :albums, only: [] do
    resources :tracks, only: [:new]
  end
  resources :tracks, except: [:new, :index]
end
