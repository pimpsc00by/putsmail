Putsmail::Application.routes.draw do
  root :to => "test_emails#index"
  
  resources :test_emails
end
