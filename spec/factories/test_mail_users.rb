# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_mail_user do
    test_mail_id 1
    user_id 1
    active true
  end
end
