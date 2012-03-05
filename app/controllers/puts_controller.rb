class PutsController < ApplicationController
  
  def index
    @to1 = cookies["to1"] || cookies[:to] # to be compatible with old cookies
    @to2 = cookies["to2"]
    @to3 = cookies["to3"]
    @to4 = cookies["to4"]
    @users_counter = User.count
    @mail_counter = Property.mail_counter
  end
  
  def puts_mail
    mail_arr = params[:mail]
    json_data = {}
    unless mail_arr.is_a? Array
      maill_arr = [mail_arr]
    end    
    mail_arr.uniq.each_with_index do | mail, index |
      session["to#{index + 1}"] = mail
      cookies["to#{index + 1}"] = {
         :value => mail,
         :expires => 10.years.from_now
      }
      puts_mail = PutsMail.new(:to => mail, :subject => params[:subject], :body => params[:body])
      puts_mail.save
      json_data ={
        :errors => puts_mail.errors,
        :mail_counter => Property.mail_counter
      }
      break unless puts_mail.errors.empty?
    end
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
    redirect_to root_path, :notice => "Your e-mail was unsubscribed! To subscribe it again, send an e-mail to subscribe@putsmail.com."
  end
  
end
