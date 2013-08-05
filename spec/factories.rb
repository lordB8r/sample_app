# by using :user, we get factory_girl to simulate the user model
FactoryGirl.define do
  factory :user do |user|
      user.name                   "JP Bader"
      user.email                  "jp@zavteq.com"
      user.password               "foobar"
      user.password_confirmation  "foobar"
    end
end