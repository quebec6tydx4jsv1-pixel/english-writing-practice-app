Rails.application.routes.draw do
  get "terms", to: "pages#terms"
  get "privacy", to: "pages#privacy"
  get "contact", to: "pages#contact"
  
  # get "pages/terms"
  # get "pages/privacy"
  # get "pages/contact"
  # get "home/index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"

  resources :questions, only: [:new, :create, :show] # 問題の作成と表示のルーティングを定義。これにより、ユーザーが新しい問題を作成したり、既存の問題を表示したりできるように

  resources :user_answers, only: [:create, :show] do
    resource :ai_correction, only: [:create]
  end

  resources :user_weak_expressions, only: [:index, :create, :edit, :update, :destroy] do
    resources :review_questions, only: [:create, :show] do
      resources :review_answers, only: [:create, :show, :update]
    end
  end

  resource :dashboard, only: [:show]

  # get "user_answers/show"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
