require 'spec_helper'

describe User do
  
  it 'should create a token' do
    apu = User.create(:mail => 'apu@kwik-e-mart.com')
    apu.valid?.should be_true
    apu.new_record?.should be_false
    apu.token.nil?.should be_false
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
