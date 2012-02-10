require "spec_helper"

describe UserMailer do

  before(:each) do  
    ActionMailer::Base.delivery_method = :test  
    ActionMailer::Base.perform_deliveries = true  
    ActionMailer::Base.deliveries = []  
  end
  
  it 'should be successful' do
    user = mock(User)
    user.stub!(:mail).and_return('apu@kwikemart.com')
    user.stub!(:token).and_return('123456')
    mail = UserMailer.registration_confirmation(user).deliver
    ActionMailer::Base.deliveries.size.should == 1  
    mail.body.should =~ /apu@kwikemart.com/
    mail.body.should =~ /123456/
    mail.body.should_not =~ /Your token was reset\! The previous token was disabled/
  end
  
end
