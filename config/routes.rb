Rails.application.routes.draw do
  get "ai_corrections/create"
  # get "home/index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  
  resorces :user_answers, only: [:show] do
    resource :ai_correction, only: [:create]
  end

  # resources :user_answers, only: [:show] # これで /user_answers/:id にアクセスすると UserAnswersController の show アクションが呼び出されるようになります。
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
