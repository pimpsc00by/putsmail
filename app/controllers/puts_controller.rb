class PutsController < ApplicationController
  
  def index
    @to = cookies[:to]
    @users_counter = User.count
    @mail_counter = Property.mail_counter
  end
  
  def puts_mail
    mail = params[:mail]
    session[:to] = mail
    cookies[:to] = {
       :value => mail,
       :expires => 10.years.from_now
    }
    puts_mail = PutsMail.new
    puts_mail.puts_mail(mail, params[:subject], params[:body])
    json_data ={
      :errors => puts_mail.errors,
      :mail_counter => Property.mail_counter
    }
    render :text => json_data.to_json
  end
  
  def premailer
    premailer = Premailer.new(params[:body], {:warn_level => Premailer::Warnings::SAFE, :with_html_string => true})
    json_data ={
      :body => premailer.to_inline_css,
      :warnings => premailer.warnings
    }
    render :text => json_data.to_json
  end
  
  def unsubscribe
    User.unsubscribe params[:token]
    redirect_to :root_path, :notice => "Your e-mail was unsubscribed! To subscribe it again, send an e-mail to subscribe@putsmail.com."
  end
  
end
