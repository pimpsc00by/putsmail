class Property < ActiveRecord::Base
  def self.increment_mail_counter
    mail_counter = Property.find_or_create_by_key("mail_counter", :value => 0)
    mail_counter.value = mail_counter.value.to_i + 1
    mail_counter.save!
    mail_counter.value.to_i
  end
  
  def self.mail_counter
    Property.find_or_create_by_key("mail_counter", :value => 0).value.to_i
  end
end
