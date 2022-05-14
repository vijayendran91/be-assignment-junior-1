Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "user#sign_in"
  post "user/sign_in", :to => "user#sign_in"

end
