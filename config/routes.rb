Rails.application.routes.draw do
  root "welcome#index"

  devise_for :users

  resources :lists do
      get :analytics, on: :member
      get :pie_chart, on: :member
      get :line_chart, on: :member
    resources :expenses do
      collection do
        get :past_dated
        post :do_past_dated
      end
    end
  end

  resources :monthly_bills

end
