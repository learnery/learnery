# see https://github.com/thoughtbot/factory_girl/wiki/Usage
#http://robots.thoughtbot.com/post/254496652/aint-no-calla-back-girl
FactoryGirl.define do
  factory :rsvp, aliases: [ :open_rsvp ], class: Learnery::OpenRsvp do
    event 
    user 
  end

  factory :rsvp_with_waitlist, class: Learnery::RsvpWithWaitlist do
    association :event, factory: :event_with_waitlist
    user 
  end

  factory :apply_for_rsvp, class: Learnery::ApplyForRsvp do
    association :event, factory: :event_with_application
    user 
  end

end


