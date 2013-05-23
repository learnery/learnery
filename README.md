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


![learnery with theme webdev](http://learnery-staging-webdev.github.io/images/screenshot-2.png)

[learnery with theme webdev](http://learnery-staging-webdev.herokuapp.com/)


![learnery with theme coderdojo](http://learnery.github.io/images/screenshot-3.png)

[learnery with theme coderdojo](http://learnery-staging-coderdojo.herokuapp.com/)


![learnery with theme railsgirls](http://learnery.github.io/images/screenshot-4.png)

[learnery with theme railsgirls](http://learnery-staging-railsgirls.herokuapp.com/)



INSTALL
======

Clone this repository and start your rails server:

    git clone https://github.com/learnery/learnery.git my-learnery-site
    cd my-learnery-site/
    bundle install
    rake db:migrate
    rails s

and play around with it on http://localhost:3000/


### deploying to heroku

You can deploy to heroku:

    heroku create
    git push heroku master
    heroku run rake db:migrate
    heroku open

congratulations, your site is online!


### switching themes

You can try one of the ready made themes from https://github.com/learnery :
Edit the Gemfile.theme to use another Theme:

    gem 'learnery-theme', :git => 'https://github.com/learnery/theme-blank.git'
    gem 'learnery-theme', :git => 'https://github.com/learnery/theme-webdev.git'
    gem 'learnery-theme', :git => 'https://github.com/learnery/theme-coderdojo.git'
    gem 'learnery-theme', :git => 'https://github.com/learnery/theme-railsgirls.git'


### modifying a theme

To make your own theme fork one of the themes mentioned above.
Clone the repository and edit the files:

    ├── app
    │   └── views
    │       └── application
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




WORK IN PROGRESS
==============

Backlog
---------------
moved to [Pivotaltracker](https://www.pivotaltracker.com/s/projects/829661)


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



