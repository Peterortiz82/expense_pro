Rails.application.routes.draw do
  root "welcome#index"

  devise_for :users

  resources :expenses do
    collection do
      get :past_dated
      post :do_past_dated
    end
  end

  resources :monthly_bills

end
