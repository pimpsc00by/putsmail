require 'spec_helper'

describe PutsMail do
  
  it 'should puts mail' do
    apu = User.create(:mail => 'apu@kwik-e-mart.com')
    puts_mail = PutsMail.new
    subject = 'Hello Apu'
    body = 'Are you interested in new oportunities?'
    mail_counter = Property.mail_counter
    puts_mail.puts_mail(apu.mail, apu.token, subject, body)
    puts_mail.valid?.should be_true
    (mail_counter + 1).should eql(Property.mail_counter)
    # PutsMailer.any_instance.should_receive(:puts_mail).with(apu.mail, subject, body)
  end
  
  it 'should not puts mail with invalid mail' do
    apu = User.create(:mail => 'apu@kwik-e-mart.com')
    puts_mail = PutsMail.new
    mail_counter = Property.mail_counter
    puts_mail.puts_mail(apu.mail, apu.token, 'Hello Apu')
    mail_counter.should eql(Property.mail_counter)
    puts_mail.valid?.should be_false
    puts_mail.errors['body'].should eql("can't be blank")
  end
  
  it 'should not puts mail with invalid to' do
    puts_mail = PutsMail.new
    puts_mail.puts_mail(nil, nil, 'Hello Apu', 'Are you interested in new oportunities?')
    puts_mail.valid?.should be_false
    puts_mail.errors['to'].should eql("can't be blank")
    puts_mail.errors['token'].should eql("can't be blank")
  end
  
  it 'should not puts mail when to and token do not match' do
    apu = User.create(:mail => 'apu@kwik-e-mart.com')
    puts_mail = PutsMail.new
    puts_mail.puts_mail(apu.mail, nil, 'Hello Apu', 'Are you interested in new oportunities?')
    puts_mail.valid?.should be_false
    puts_mail.errors[''].should eql("to and token don't match")
  end
  
end
