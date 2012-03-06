#coding: utf-8
Factory.define :subscribed_user, :class => User do |f|
  f.sequence(:mail) {|n| "apu#{n}@kwikemart.com"}
  f.subscribed true
end
