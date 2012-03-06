require 'spec_helper'

describe User do
    
  it 'should create a token' do
    # http://en.wikipedia.org/wiki/Apu_Nahasapeemapetilon
    # http://en.wikipedia.org/wiki/Kwik-E-Mart
    apu2 = User.new(:mail => 'apu2@kwik-e-mart.com')
    apu2.save
    apu2.valid?.should be_true
    apu2.new_record?.should be_false
    apu2.token.nil?.should be_false
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
  
end
