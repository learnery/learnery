# see https://github.com/thoughtbot/factory_girl/wiki/Usage
FactoryGirl.define do
  factory :user do
    sequence(:email)    { |n| "foo#{n}@example.com" }
    sequence(:nickname) { |n| "Some Uniqe Name #{n}" }
    password "geheim12"
    password_confirmation "geheim12"
  end
  factory :user_only_with_email , :class => User do
    email "someone2@somehost.xxx"
    password "geheim12"
    password_confirmation "geheim12"
  end
  factory :user_only_with_nickname , :class => User do
    nickname "ANick"
    password "geheim12"
    password_confirmation "geheim12"
  end

  factory :admin_user, :parent => :user do
    admin true
  end


end
