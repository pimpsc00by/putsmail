class PutsMail
  
  def puts_mail(to, token, subject = 'Puts Mail - Test', body = '')
    @errors = {}
    if body.to_s.blank?
      @errors.merge!({'body' => "can't be blank"})
    end
    if to.to_s.blank?
      @errors.merge!({'to' => "can't be blank"})
    end
    if token.to_s.blank?
      @errors.merge!({'token' => "can't be blank"})
    end
    to.to_s.strip!
    token.to_s.strip!
    user = User.find_by_mail_and_token(to, token)
    if user.nil?
      @errors.merge!({'' => "to and token don't match"})
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