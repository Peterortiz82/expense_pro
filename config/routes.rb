Rails.application.routes.draw do
  root "welcome#index"

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  devise_for :users

  resources :lists do
    get :analytics, on: :member
    get :pie_chart, on: :member
    get :line_chart, on: :member
    resources :list_permissions, only: [:index, :create, :destroy]
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
