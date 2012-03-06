require 'spec_helper'

describe PutsMail do  
  it 'should puts mail' do
    apu = Factory :subscribed_user
    subject = 'Hello Apu'
    body = 'Are you interested in new oportunities?'
    mail_counter = Property.mail_counter
    puts_mail = PutsMail.new :to => apu.mail, :subject => subject, :body => body
    puts_mail.save.should be_true
    (mail_counter + 1).should eql(Property.mail_counter)
  end
  describe "Validate the attributes" do
    it 'should not puts mail with nil body' do
      apu = Factory :subscribed_user
      mail_counter = Property.mail_counter
      puts_mail = PutsMail.new :to => apu.mail, :subject => 'Hello Apu', :body => nil
      puts_mail.save.should be_false
      mail_counter.should eql(Property.mail_counter)
      puts_mail.errors['body'].should eql(["can't be blank"])
    end
  
    it 'should not puts mail with nil subject' do
      apu = Factory :subscribed_user
      mail_counter = Property.mail_counter
      puts_mail = PutsMail.new :to => apu.mail, :subject => nil, :body => 'Hello Apu'
      puts_mail.save.should be_false
      mail_counter.should eql(Property.mail_counter)
      puts_mail.errors['subject'].should eql(["can't be blank"])
    end
  
    it 'should not puts mail with nil to' do
      mail_counter = Property.mail_counter
      puts_mail = PutsMail.new :to => nil, :subject => 'Hello Apu', :body => nil
      puts_mail.save.should be_false
      mail_counter.should eql(Property.mail_counter)
      puts_mail.errors['to'].should eql(["does not appear to be valid"])
    end
  end
  
end
