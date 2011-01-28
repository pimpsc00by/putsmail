class PutsMail
  
  def puts_mail(to, token, subject = 'Puts Mail - Test', body = '')
    @errors = {}
    to = to.to_s.strip
    token = token.to_s.strip
    if body.blank?
      @errors.merge!({'body' => "can't be blank"})
    end
    if to.blank?
      @errors.merge!({'to' => "can't be blank"})
    end
    if token.blank?
      @errors.merge!({'token' => "can't be blank"})
    end
    if(!to.blank? and !token.blank?)
      user = User.find_by_mail_and_token(to, token)
      if user.nil?
        @errors.merge!({'' => "to and token don't match"})
      end  
    end
    if valid?  
      PutsMailer.puts_mail(user.mail, subject, body).deliver
      Property.increment_mail_counter
    end
  end
  
  def valid?
    @errors.to_a.empty?
  end
  
  def errors
    @errors
  end
  
end