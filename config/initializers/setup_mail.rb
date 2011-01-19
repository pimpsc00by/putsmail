# http://blog.heroku.com/archives/2009/11/9/tech_sending_email_with_gmail/
# http://docs.heroku.com/sendgrid
# http://asciicasts.com/episodes/206-action-mailer-in-rails-3
ActionMailer::Base.smtp_settings = {  
  :address              => 'smtp.gmail.com',  
  :port                 => 587,  
  :domain               => 'putsmail.com',  
  :user_name            => ENV['EMAIL_FROM']
  :password             => ENV['EMAIL_FROM_PASSWORD']
  :authentication       => 'plain',  
  :enable_starttls_auto => true  
}

ActionMailer::Base.default_url_options[:host] = 'http://putsmail.com'