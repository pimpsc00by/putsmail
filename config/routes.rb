Putsmail::Application.routes.draw do
  mount PutsmailPro::Engine => "/pro"

  resources :galleries, only: [:index, :show]

  post "subscription_listener/subscribe"
  post "subscription_listener/unsubscribe"

  get "site/index"

  root :to => "site#index"

  namespace :api do
    put "/add_to_gallery"      , to: "test_mails#add_to_gallery"
    resources :test_mails      , only: [:create, :show, :update]
    resources :test_mail_users , except: [:edit]
    resources :check_htmls     , only: [:create]
  end

  get "/test_mails/:id" , to: "site#old_gallery_item"
  get "/gallery"        , to: "site#old_gallery"
  get "/tests/:token"   , to: "site#index"
  get "/:token"         , to: "site#old_index"
end
