# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test_mail do
    subject "Test mail"
    body "Hi"
    recipients ["pablo@pablocantero.com"]
  end
end
