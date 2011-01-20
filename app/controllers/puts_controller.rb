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
    render :text => puts_mail.errors.to_json
  end
  
end
