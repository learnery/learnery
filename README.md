This software is work in progress and has not been released yet!

[![Build Status](https://travis-ci.org/learnery/learnery.png?branch=master)](https://travis-ci.org/learnery/learnery)

[![Code Climate](https://codeclimate.com/github/learnery/learnery.png)](https://codeclimate.com/github/learnery/learnery)

README
========

Learnery is a rails app you can use to organize
open learning events, like railsbridge, barcamps, user groups,
meetups, hackathons.  You can adapt the theme to your
liking and deploy the app to heroku in a few simple steps.

Here are some example installations with different themes:

![learnery with blank theme](http://learnery.github.io/images/screenshot-1.png)

[learnery with blank theme](http://learnery-staging.herokuapp.com/)


![learnery with theme webdev](http://learnery.github.io/images/screenshot-2.png)

[learnery with theme webdev](http://learnery-staging-webdev.herokuapp.com/)


![learnery with theme coderdojo](http://learnery.github.io/images/screenshot-3.png)

[learnery with theme coderdojo](http://learnery-staging-coderdojo.herokuapp.com/)


![learnery with theme railsgirls](http://learnery.github.io/images/screenshot-4.png)

[learnery with theme railsgirls](http://learnery-staging-railsgirls.herokuapp.com/)



Installation
======

Clone this repository and start your rails server:

    git clone https://github.com/learnery/learnery.git my-learnery-site
    cd my-learnery-site/
    bundle install

    there is a simple theme in test/dummy which can be used for testing:
    rake learnery:install:migrations
    cd test/dummy
    rake db:migrate
    rails s

and play around with it on http://localhost:3000/


### Deploying To Heroku

You can deploy to heroku: (if you don't have a heroku account yet, go to [https://get.heroku.com](https://get.heroku.com) and get one first)

    heroku create
    git push heroku master
    heroku run rake db:migrate
    heroku open

congratulations, your site is online!


### Switching Themes

You can try one of the ready made themes from https://github.com/learnery :

Edit Gemfile.theme to use another theme:

    gem 'learnery-theme', :git => 'https://github.com/learnery/learnery-theme.git'
    gem 'learnery-theme', :git => 'https://github.com/learnery/learnery-theme-webdev.git'
    gem 'learnery-theme', :git => 'https://github.com/learnery/learnery-theme-coderdojo.git'
    gem 'learnery-theme', :git => 'https://github.com/learnery/https://github.com/learnery/learnery-theme-railsgirls.git'


### Creating your own Theme

To make your own theme fork one of the themes mentioned above.
Clone the repository and edit the files:

    ├── app
    │   └── views
    │       └── application
    │           ├── _site_name.html.erb
    │           ├── _site_description.html.erb
    │           ├── _footer.html.erb
    │           └── _site_links.html.erb
    └── vendor
        └── assets
            └── stylesheets
                ├── style.css.less      = your main stylesheet
                └── variables.css.less  = variables for bootstrap and you own stylesheet


build the gem

    rake build

And test it locally by specifying the full path in Gemfile.theme of you learnery app:

    gem 'learnery-theme', :path => '/really/long/path/to/learnery-theme'

repeat until you are satisfied with your changes.  Then
push your gem to a public repository, and change the reference in Gemfile.theme in you learnery app:

    gem 'learnery-theme', :git => 'https://github.com/MYNAME/theme-MYTHEME.git'

(bk tbd: it should be possible to use bundler groups here)


### Continuous Deployment

The app contains a script that deploys to heroku automatically from travis ci:

    ci/deploy.rb

As travis ci does truncate the git repo, run the first deploy from your own, complete repo like this:

    export HEROKU_API_KEY=xxxx
    export TRAVIS_TEST_RESULT="0"
    export LEARNERY_THEME=default

    ci/copytheme.sh
    bundle
    bundle exec ci/deploy.rb <herokuappname>

### Configuring OAuth Authorizations

Learnery has oauth authorizations for twitter, github and steam.
To active them on your page, you have to register you app and get oauth keys from the providers, then make them known to your app via environment variables on the server.

If you don't want to use all oauth providers, configure them in
config/initializers/learnery.rb:

    Rails.application.config.oauth_providers = [:github, :twitter, :steam]


#### Configuring Twitter Authorization

If you want to use Twitter Authorization, you need to register your app / instance of learnery with twitter at https://dev.twitter.com/apps/new

To test locally, set the environment variables before running rails server (pick up your keys from http://dev.twitter.com !)

    export TWITTER_CONSUMER_KEY=xxx
    export TWITTER_CONSUMER_SECRET=xxx

And finally make these keys known to heroku with

    heroku config:set --app learnery-staging TWITTER_CONSUMER_KEY=xxx TWITTER_CONSUMER_SECRET=xxx

#### Github

 * [Link to App Registration](https://github.com/settings/applications)
 * Github keys:
  * GITHUB_KEY
  * GITHUB_SECRET

#### Steam

 * [Link to App Registration Page](http://steamcommunity.com/dev/apikey)
 * Steam Key:
  * STEAM_WEB_API_KEY


FURTHER INFORMATION
==============

Backlog
---------------
on Github, with [issues](https://github.com/learnery/learnery/issues?state=open)


Heroku
--------------

[http://learnery.herokuapp.com](http://learnery.herokuapp.com)


Things we may want to cover:
-----------

* Ruby version

    2.0.0

* System dependencies

   see gemfile

* Configuration

* Database creation

* Database initialization

* How to run the test suite

    rake

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

    git push heroku master



