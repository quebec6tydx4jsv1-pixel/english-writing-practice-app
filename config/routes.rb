Rails.application.routes.draw do
  get "mistakes/index" # scaffold で自動生成されたルーティングだが、下記の resources :ai_corrections 内で mistakes をネストさせているため、こちらは不要になる可能性が高い。
  get "ai_corrections/create" # こちらも scaffold で自動生成されたルーティングだが、AI Correction の作成は User Answer に対して行うため、こちらも不要になる可能性が高い。
  # get "home/index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"

  resources :user_answers, only: [:show] do
    resource :ai_correction, only: [:create]
  end

  resources :ai_corrections do # リソースをネストさせ、AI Correction に関連する Mistake を管理するためのルーティングを定義
    resources :mistakes, only: [:index]
  end

  resources :user_weak_expressions, only: [:index, :create, :update] do # リソースをネストさせ、User Weak Expression に関連する Review Question を管理するためのルーティングを定義
    resource :review_question, only: [:show]
  end

  resources :review_answers, only: [:create]

  resource :dashboard, only: [:show] # ダッシュボードのルーティングを定義

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
