Rails.application.routes.draw do
  devise_for :users
  resources :monthly_bills
  resources :expenses
  root "welcome#index"
end
