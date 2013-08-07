# by using :user, we get factory_girl to simulate the user model
FactoryGirl.define do
  factory :user do
      sequence(:name) {|n|  "Person #{n}"}
      sequence(:email) {|n| "person_#{n}@example.org"}
      password               "foobar"
      password_confirmation  "foobar"
  end
end
