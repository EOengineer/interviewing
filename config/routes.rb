Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "spa/index"
  root to: "spa#index"

  namespace :api, format: :json do
    namespace :v1 do
      resources :teams, only: :index
    end
  end
end
