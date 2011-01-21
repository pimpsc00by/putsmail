require 'spec_helper'

describe User do
  
  it 'should create a token' do
    # http://en.wikipedia.org/wiki/Apu_Nahasapeemapetilon
    # http://en.wikipedia.org/wiki/Kwik-E-Mart
    apu = User.reset_or_create_by_mail('apu@kwik-e-mart.com')
    apu.valid?.should be_true
    apu.new_record?.should be_false
    apu.token.nil?.should be_false
  end
  
  it 'should not save with invalid mail' do
    # http://en.wikipedia.org/wiki/Ned_Flanders
    # http://en.wikipedia.org/wiki/List_of_fictional_locations_in_The_Simpsons#The_Leftorium
    # invalid 1
    ned = User.new(:mail => 'ned@the-leftorium')
    ned.valid?.should be_false
    # invalid 2
    ned.mail = 'nedthe-leftorium.com'
    ned.valid?.should be_false
    # invalid 3
    ned.mail = 'ned the-leftorium.com'
    ned.valid?.should be_false  
    # valid 1
    ned.mail = 'ned@the-leftorium.com'
    ned.valid?.should be_true
  end
  
  it 'should reset the token' do
    apu = User.reset_or_create_by_mail('apu@kwik-e-mart.com')
    apu.token_reset?.should be_false
    
    apu2 = User.reset_or_create_by_mail('apu@kwik-e-mart.com')
    apu2.token_reset?.should be_true
    
    apu.token.should_not eql(apu2.token)
  end
  
end
