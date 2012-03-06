Putsmail::Application.routes.draw do
  root :to => 'puts#index'
  
  post '/puts_mail' => 'puts#puts_mail'
    
  post '/premailer' => 'puts#premailer'
  
  get '/unsubscribe' => 'puts#unsubscribe'
end
