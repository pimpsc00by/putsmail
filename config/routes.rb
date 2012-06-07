Putsmail::Application.routes.draw do
  resources :galleries, only: [:index, :show]

  post "subscription_listener/subscribe"
  post "subscription_listener/unsubscribe"

  get "site/index"

  root :to => "site#index"
  
  namespace :api do
    resources :test_mails, only: [:create, :show, :update]
    resources :test_mail_users, only: [:create, :index, :show, :destroy, :update]
    resources :check_htmls, only: [:create]
  end
  
  match '*path', to: 'site#index'
end
