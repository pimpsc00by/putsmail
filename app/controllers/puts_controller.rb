class PutsController < ApplicationController
  
  def index
    @to = session[:to]
    @token = session[:token]
  end
  
  def puts_mail
    session[:to] = params[:mail]
    session[:token] = params[:token]
    puts_mail = PutsMail.new
    puts_mail.puts_mail(params[:mail], params[:token], params[:subject], params[:body])
    json_data ={
      :errors => puts_mail.errors
    }
    render :text => json_data.to_json
  end
  
end
