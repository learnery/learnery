# see https://github.com/thoughtbot/factory_girl/wiki/Usage
#http://robots.thoughtbot.com/post/254496652/aint-no-calla-back-girl
FactoryGirl.define do
  factory :rsvp_event, class: Learnery::Event do
    name "Some interesting event"
    starts 10.days.from_now
    ends 2.hours.from_now + 10.days
    description "Bla bla"
    venue "Berlin"
  end
  factory :open_rsvp_1, class: Learnery::OpenRsvp do
    answer :yes
    event factory: :rsvp_event
    user factory: :user_sequence
  end
  factory :open_rsvp_2, class: Learnery::OpenRsvp do
    answer :no
    event factory: :rsvp_event
    user factory: :user_sequence
  end

  factory :rsvp_1, class: Learnery::Rsvp do
    answer :yes
    event factory: :rsvp_event
    user factory: :user_sequence
  end
  factory :rsvp_2, class: Learnery::Rsvp do
    answer :no
    event factory: :rsvp_event
    user factory: :user_sequence
  end
  factory :rsvp_3, class: Learnery::Rsvp do
    answer :maybe
    event factory: :rsvp_event
    user factory: :user_sequence
  end

end


