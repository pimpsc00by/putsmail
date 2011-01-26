class Property < ActiveRecord::Base
  
  def self.increment_mail_counter
    mail_counter = Property.find_or_create_by_key('mail_counter', :value => 0)
    # http://apidock.com/rails/ActiveRecord/Base/increment_counter/class
    Property.increment_counter(:value, mail_counter.id)
    mail_counter.reload.value.to_i
  end
  
  def self.mail_counter
    Property.find_or_create_by_key('mail_counter', :value => 0).value.to_i
  end
  
end
