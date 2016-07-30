Rails.application.routes.draw do
  root "welcome#index"

  devise_for :users

  resources :lists do
    get :analytics, on: :member
    get :pie_chart, on: :member
    get :line_chart, on: :member
    resources :list_permissions, only: [:index, :create]
    resources :expenses do
      collection do
        get :past_dated
        post :do_past_dated
      end
    end
  end

  resources :shared_lists, only: [:index]
  resources :monthly_bills

end
