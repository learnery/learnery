# thou shall not be attached to data in test databases.
# here's the rake task that fills the db with some initial data.
# re-setup staging database:
# heroku run rake bootstrap:all --app learnery-staging

# wipe and bootstrap all staging databases:

#heroku pg:reset DATABASE --app learnery-staging --confirm learnery-staging
#heroku pg:reset DATABASE --app learnery-staging-coderdojo --confirm learnery-staging-coderdojo
#heroku pg:reset DATABASE --app learnery-staging-railsgirls --confirm learnery-staging-railsgirls
#heroku pg:reset DATABASE --app learnery-staging-webdev --confirm learnery-staging-webdev
#
#heroku run rake db:setup --app learnery-staging
#heroku run rake db:setup --app learnery-staging-coderdojo
#heroku run rake db:setup --app learnery-staging-railsgirls
#heroku run rake db:setup --app learnery-staging-webdev
#
#heroku run rake bootstrap:all --app learnery-staging
#heroku run rake bootstrap:all --app learnery-staging-coderdojo
#heroku run rake bootstrap:all --app learnery-staging-railsgirls
#heroku run rake bootstrap:all --app learnery-staging-webdev


# below rake task adapted from stackoverflow:
# http://stackoverflow.com/questions/62201/how-and-whether-to-populate-rails-application-with-initial-data
namespace :learnery do
  namespace :bootstrap do
    desc "Create some default users"
    task :default_profiles => :environment do
      Learnery::User.create(email: "bjelli@gmail.com",
                  nickname: "bjelline",
                  firstname: "Brigitte",
                  lastname: "Jellinek",
                  provider: "twitter",
                  uid: "4206851",
                  admin: true )

      Learnery::User.create(email: "drblinken@gmail.com",
                  nickname: "drblinken",
                  firstname: "Béla",
                  lastname: "Blinken",
                  provider: "github",
                  uid: "2063596",
                  admin: true)

    end

    desc "Create the default event"
    task :default_event => :environment do
      Learnery::Event.create(name: "The Future",
                   starts: 3.months.from_now,
                   ends: 3.months.from_now + 2.hours,
                   venue: "Berlin (where else)",
                   description: "we will invent it\r\n",
                   max_attendees: 1,
                   rsvp_type: "RsvpWithWaitlist" )
    end

    desc "Run all bootstrapping tasks"
    task :all => [:default_profiles, :default_event]
  end
end
