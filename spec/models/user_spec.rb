require 'spec_helper'

describe User do

  describe 'Token' do
    it 'should create a token' do
      # http://en.wikipedia.org/wiki/Apu_Nahasapeemapetilon
      # http://en.wikipedia.org/wiki/Kwik-E-Mart
      apu2 = User.new(:mail => 'apu2@kwik-e-mart.com')
      apu2.save.should be_true
      apu2.token.nil?.should be_false
    end
  end

  describe 'Validations' do 
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
  
  describe 'Defaults' do
    it 'should set subscribed=true on creation' do
      user = User.create mail: 'apu@kwikemart.com'
      user.subscribed.should be_true
    end
  end

  describe 'Subscriptions' do
    it 'should unsubscribe' do
      user = Factory(:user, subscribed: true)
      User.unsubscribe user.token
      user.reload
      user.subscribed.should be_false
    end
  end

end
