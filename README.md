This software is work in progress and has not been released yet!

[![Build Status](https://travis-ci.org/learnery/learnery.png?branch=master)](https://travis-ci.org/learnery/learnery)

[![Code Climate](https://codeclimate.com/github/learnery/learnery.png)](https://codeclimate.com/github/learnery/learnery)

README
========

Learnery is a rails engine you can use in your rails app to organize
open learning events, like railsbridge, barcamps, user groups,
meetups, hackathons.  You can adapt it to your
liking and deploy the app to heroku in a few simple steps.

Here are some example installations using the learnery engine:

![learnery in default app](http://learnery.github.io/images/screenshot-1.png)

[learnery in default app](http://learnery-staging.herokuapp.com/)


![learnery in  webdev app](http://learnery.github.io/images/screenshot-2.png)

[learnery in webdev app](http://learnery-staging-webdev.herokuapp.com/)


![learnery in coderdojo app](http://learnery.github.io/images/screenshot-3.png)

[learnery in coderdojo app](http://learnery-staging-coderdojo.herokuapp.com/)


![learnery in railsgirls app](http://learnery.github.io/images/screenshot-4.png)

[learnery in  railsgirls app](http://learnery-staging-railsgirls.herokuapp.com/)



Installation
======

To use learnery, you have to have a rails application. This application uses learnery as a rail engine. 
There's two ways to do that:

1. Clone one of the example apps and work from there
2. Build your own app from scratch


Build your own app from scratch
---------------------

create a new app:

    $ rails new <your-app-name>
    $ cd <your-app-name>

and use learnery from within it:

add the learnery gem to your gemfile 

     # add this line to Gemfile within the rails application
     gem 'learnery', :git => 'git://github.com/learnery/learnery.git', branch: 'stable'

run bundler:

    $ bundle

generate the initial theme files (only pretend at first)

    $ rails generate  learnery:theme -p

if you like what the generator does, run it for real, without the -p = pretend flag

    $ rails generate learnery:theme

then, install the migrations for the learnery engine and run them:

    $ rake learnery:install:migrations
    $ rake db:migrate

mount the learnery engine in config/routes.rb: add this line somewhere between the
<YOURAPPNAME>::Application.routes.draw do
and the last end

    mount Learnery::Engine => "/", as: "learnery"

finally, start the server locally:

    $ rails server



### Deploying To Heroku

You can deploy to heroku: (if you don't have a heroku account yet, go to [https://get.heroku.com](https://get.heroku.com) and get one first)

    heroku create
    git push heroku master
    heroku run rake db:migrate
    heroku open

congratulations, your site is online!


### Internationalization (I18n)

The engine comes with german and english texts.
To switch to german edit your config/application.rb

    # in file config/application.rb
    config.i18n.default_locale = :de

To add a new language, say :fi, create a file
config/locales/learnery.fi.yml by copying the current
english or german version from github:
https://github.com/learnery/learnery/blob/master/config/locales/learnery.en.yml
https://github.com/learnery/learnery/blob/master/config/locales/learnery.de.yml

We accept pull requests for new languages!

### Adapting the look and feel of your app

Here are the most important files to edit:

    app/
    ├── assets
    │   ├── images
    │   │   ├── *            <-- add your images here
    │   │   └── favicon.ico
    │   └── stylesheets
    │       ├── style.css.less      <--- add custom css here
    │       └── variables.css.less  <--- colors
    └── views
        ├── layouts                 <--- ignore!
        └── learnery
            ├── pages
            │   ├── *.html.md       <--- add "static" pages here
            │   └── about.html.md
            └── theme
                ├── _footer.html.erb
                ├── _site_description.html.erb
                ├── _site_links.html.erb        <--- add links to top menu here
                └── _site_name.html.erb


If you want to change the layout of the whole page
you can do so by adding a file app/views/learnery/shared/_main_layout.html.erb
it's probably best to copy it from one of the example apps and work from there.


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



