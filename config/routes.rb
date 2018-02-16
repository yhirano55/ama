Rails.application.routes.draw do
  get    "/auth/github/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resources :users, only: %i[index show]
  resources :issues
  resources :comments
  resource :like, only: %i[create destroy]

  direct(:login) { "/auth/github?origin=#{request.original_url}" }
  direct(:github) { |username_or_repo| "https://github.com/#{username_or_repo}" }

  root "issues#index"
end
