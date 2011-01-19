require 'spec_helper'

describe User do
  
  it 'should create a token' do
    apu = User.create(:mail => 'apu@kwik-e-mart.com')
    apu.token.should eql('16ff12167572d9c6a501f0da76a12207')
  end
  
  it 'should not save with invalid mail' do
    # invalid 1
    homer = User.new(:mail => 'homer@springfield-nuclear-power-plant')
    homer.valid?.should be_false
    # invalid 2
    homer.mail = 'homerspringfield-nuclear-power-plant.com'
    homer.valid?.should be_false
    # invalid 3
    homer.mail = 'homer springfield-nuclear-power-plant.com'
    homer.valid?.should be_false  
    # valid 1
    homer.mail = 'homer@springfield-nuclear-power-plant.com'
    homer.valid?.should be_true
  end
  
end
