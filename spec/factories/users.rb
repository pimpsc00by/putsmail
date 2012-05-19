#coding: utf-8

FactoryGirl.define do
  factory :user do
    sequence(:mail) {|n| "apu#{n}@kwikemart.com"}
    subscribed true
  end
end
