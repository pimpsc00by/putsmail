class PutsController < ApplicationController
  
  def index
    # @to = params[:to] || cookies[:to]
    # @token = params[:token] || cookies[:token]
    @to = params[:to] || session[:to]
    @token = params[:token] || session[:token]
    @users_counter = User.count
    @mail_counter = Property.mail_counter
  end
  
  def puts_mail
    @mail = params[:mail]
    @token = params[:token]
    session[:to] = @mail
    session[:token] = @token
    # cookies[:to] = {
    #    :value => @mail,
    #    :expires => 10.years.from_now
    # }
    # cookies[:token] = {
    #    :value => @token,
    #    :expires => 10.years.from_now
    # }
    puts_mail = PutsMail.new
    puts_mail.puts_mail(@mail, @token, params[:subject], params[:body])
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
  
end
