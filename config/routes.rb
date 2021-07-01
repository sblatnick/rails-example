Rails.application.routes.draw do
  root "weather#index"
  get "/tweets", to: "tweets#index"
  get "/weather", to: "weather#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
