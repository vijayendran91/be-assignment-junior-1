Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "user#sign_in"
  post "user/sign_in", :to => "sessions#create"
  post "user/sign_up", :to => "user#sign_up"
  get "user/sign_up", :to => "user#sign_up"
  get "user/sign_in", :to => "user#sign_in"
  get "user/dashboard", :to => "user#dashboard"

end
