class PutsMail
  
  def puts_mail(to, subject, body)
    @errors = {}
    to = to.to_s.strip
    if subject.blank?
      @errors.merge!({'subject' => "can't be blank."})
    end
    if body.blank?
      @errors.merge!({'body' => "can't be blank."})
    end
    if to.blank?
      @errors.merge!({'to' => "can't be blank."})
    else
      user = User.find_or_create_by_mail(to)
      if user.valid? and !user.subscribed?
         @errors.merge!({'' => "the e-mail '#{to}' unsubscribed the Puts Mail Test E-mails. To subscribe it again, send an e-mail to subscribe@putsmail.com."})
      end
      @errors.merge!(user.errors)
    end
    if valid?  
      PutsMailer.puts_mail(user, subject, body).deliver
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