require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  get "spa/index"
  root to: "spa#index"

  namespace :api, format: :json do
    namespace :v1 do
      resources :teams, only: :index
    end
  end

  get '*path', to: 'spa#index'
end
