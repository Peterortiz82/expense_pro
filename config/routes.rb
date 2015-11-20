Rails.application.routes.draw do
  devise_for :users

  resource :expenses
  root "welcome#index"
end
