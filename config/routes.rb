Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "user#sign_in", :to => "user#sign_in"
  post "user/sign_in", :to => "sessions#create"
  post "user/sign_up", :to => "user#sign_up"
  get "user/sign_up", :to => "user#sign_up"
  get "user/sign_in", :to => "user#sign_in"
  delete "user/sign_out", :to => "sessions#destroy"
  get "user/dashboard", :to => "user#dashboard"
  get "user/expenses_with_user", :to => "user#expenses_with_user"
  get "user/friends_expenses", :to => "user#friends_expenses"

  get "user/add_expense", :to => "user#add_expense"
  post "user/add_expense", :to => "user#add_expense"

  get "user/settle_expense", :to => "user#settle_expense"
  post "user/settle_expense", :to => "user#settle_expense"
  get "user/all_expenses_log", :to => "user#expenses_log"
end
