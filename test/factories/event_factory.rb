# see https://github.com/thoughtbot/factory_girl/wiki/Usage
FactoryGirl.define do
  factory :event, class: Learnery::Event do
    name "User Group"
    starts 3.days.from_now
    ends 2.hours.from_now + 3.days
    description "Bla bla"
    venue "Berlin"
  end
  factory :past_event, class: Learnery::Event do
    sequence(:name)    { |n| "User Group #{n}"}
    starts 3.days.ago
    ends 2.hours.from_now - 3.days
    description "Bla bla"
    venue "Berlin"
  end
  factory :topic_for_event_1, class: "Learnery::Topic" do
    name "First Topic for Event"
    description "Description for first topic for event"
  end
  factory :topic_for_event_2 , class: "Learnery::Topic"do
    name "First Topic for Event"
    description "Description for first topic for event"
  end
  factory :event_with_two_topics, parent: :event do |e|
    e.topics { |t| [t.association(:topic_for_event_1),
    t.association(:topic_for_event_2)]}
  end
end

#   name "Event with two Topics"
#    starts 1.days.from_now
#    association :events, factory:topic_for_event_1
