# see https://github.com/thoughtbot/factory_girl/wiki/Usage
FactoryGirl.define do
  factory :event, aliases: [:open_event], class: Learnery::OpenEvent do
    name "User Group"
    starts 3.days.from_now
    description "Bla bla"
    venue "Berlin"
  end
  factory :event_with_waitlist, class: Learnery::EventWithWaitlist do
    name "User Group"
    starts 3.days.from_now
    description "Bla bla"
    venue "Berlin"
  end


  factory :past_event, aliases: [:past_open_event],class: Learnery::OpenEvent do
    sequence(:name)    { |n| "User Group #{n}"}
    starts 3.days.ago
    description "Bla bla"
    venue "Berlin"
  end
end

