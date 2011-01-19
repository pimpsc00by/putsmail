# http://blog.heroku.com/archives/2009/11/9/tech_sending_email_with_gmail/
# http://docs.heroku.com/sendgrid
# http://asciicasts.com/episodes/206-action-mailer-in-rails-3
ActionMailer::Base.smtp_settings = {  
  :address              => 'smtp.gmail.com',  
  :port                 => 587,  
  :domain               => 'megasename.heroku.com',  
  :user_name            => ENV['GMAIL_MEGASENAME_USER'] || 'megasename@gmail.com',  
  :password             => ENV['GMAIL_MEGASENAME_PASSWORD'] || 'birobiro',  
  :authentication       => 'plain',  
  :enable_starttls_auto => true  
}

ActionMailer::Base.default_url_options[:host] = ENV['MEGASENA_ME_DOMAIN'] || 'http://putsmail.heroku.com'