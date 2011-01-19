class PutsController < ApplicationController
  
  def index
  end
  
  def puts_mail
    puts_mail = PutsMail.new
    puts_mail.puts_mail(params[:mail], params[:token], params[:subject], params[:body])
    render :text => puts_mail.errors.to_json
  end
  
end
