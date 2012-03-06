require "spec_helper"

describe Property do
  it "should increment" do
    Property.increment_mail_counter.should eql(1)
    Property.increment_mail_counter.should eql(2)
    mail_counter = Property.find_by_key("mail_counter")
    mail_counter.value = 20
    mail_counter.save    
    Property.increment_mail_counter.should eql(21)
  end
  
  it "should return mail counter" do
    Property.mail_counter.should eql(0)
    Property.increment_mail_counter
    Property.mail_counter.should eql(1)
  end
end
