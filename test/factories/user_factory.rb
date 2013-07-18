# see https://github.com/thoughtbot/factory_girl/wiki/Usage
FactoryGirl.define do
  factory :user, :class => Learnery::User do
    sequence(:email)    { |n| "user_#{n}@example.com" }
    sequence(:nickname) { |n| "A User #{n}" }
    password "geheim12"
    password_confirmation "geheim12"
  end
  factory :user_only_with_email , :class => Learnery::User do
    email "someone2@somehost.xxx"
    password "geheim12"
    password_confirmation "geheim12"
  end
  factory :user_only_with_nickname , :class => Learnery::User do
    nickname "ANick"
    password "geheim12"
    password_confirmation "geheim12"
  end

  factory :admin_user, :parent => :user do
    admin true
  end
end
