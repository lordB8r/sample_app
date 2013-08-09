## Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :micropost do |micropost|
    micropost.content "Foo bar"
    micropost.association :user
  end
end