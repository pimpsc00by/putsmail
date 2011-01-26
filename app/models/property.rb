class Property < ActiveRecord::Base
  
  def self.increment_mail_counter
    mail_counter = Property.find_or_create_by_key('mail_counter', :value => 0)
    # http://apidock.com/rails/ActiveRecord/Base/increment_counter/class
    # Property.increment_counter(:value, mail_counter.id)
    # matilde:putsmail pablo$ heroku console
    # Ruby console for putsmail.heroku.com
    # >> Property.increment_mail_counter
    # ActiveRecord::StatementInvalid: PGError: ERROR:  COALESCE types character varying and integer cannot be matched
    # : UPDATE "properties" SET "value" = COALESCE("value", 0) + 1 WHERE ("properties"."id" = 1)
    
    mail_counter.value = mail_counter.value.to_i + 1
    mail_counter.save!
    mail_counter.value.to_i
  end
  
  def self.mail_counter
    Property.find_or_create_by_key('mail_counter', :value => 0).value.to_i
  end
  
end
