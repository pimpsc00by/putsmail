Putsmail::Application.routes.draw do
  get "site/index"

  root :to => "site#index"
  
  namespace :api do
    resources :test_mails, only: [:create, :show, :update]
    resources :check_htmls, only: [:create]
  end
  
  match '*path', to: 'site#index'
end
