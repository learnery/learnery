# see https://github.com/thoughtbot/factory_girl/wiki/Usage
FactoryGirl.define do
  factory :user do
    email "someone@somehost.xxx"
    username "Someone"
    password "geheim12"
    password_confirmation "geheim12"
  end
  factory :user_only_with_email , :class => User do
    email "someone2@somehost.xxx"
    password "geheim12"
    password_confirmation "geheim12"
  end
  factory :user_only_with_username , :class => User do
    username "AUsername"
    password "geheim12"
    password_confirmation "geheim12"
  end
end
