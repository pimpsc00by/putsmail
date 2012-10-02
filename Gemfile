source "http://rubygems.org"

gem "rails", "3.1.0"
gem "jquery-rails", ">= 0.2.6"
gem "hpricot"
gem "premailer"
gem "active_attr"
gem "backbone-on-rails"
gem "newrelic_rpm"
gem "url2png"


group :production do
  gem "pg"
end

group :development do
  gem "rspec-rails", "~> 2.4"
  gem "sqlite3-ruby", :require => "sqlite3"
  gem "heroku"
  gem "bullet"
  gem "capybara"
end

group :development, :test do
  gem "pry"
  gem "pry-nav"
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "assert_difference"
  gem "simplecov", :require => false
  gem "spork", "> 0.9.0.rc"
end

group :assets do
  gem "coffee-rails", " ~> 3.1.0"
  gem "uglifier"
  gem "sass-rails", "~> 3.1"
  gem "bootstrap-sass", "~> 2.1.0.0"
end

