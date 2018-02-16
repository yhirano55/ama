Rails.application.routes.draw do
  get    "/auth/github/callback" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  resources :users, only: %i[index show]
  resources :issues do
    resource :like, only: :destroy, likeable_type: "Issue"
  end
  resources :comments do
    resource :like, only: :destroy, likeable_type: "Comment"
  end
  resources :likes, only: :create

  direct(:login) { "/auth/github?origin=#{request.original_url}" }
  direct(:github) { |username_or_repo| "https://github.com/#{username_or_repo}" }

  root "topics#index"
end
