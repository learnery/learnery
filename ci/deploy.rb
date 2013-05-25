#!/usr/bin/env ruby
# this is called by travis ci
require 'heroku-headless'

required = %w(HEROKU_API_KEY LEARNERY_THEME TRAVIS_TEST_RESULT)
undefined = required.select{|v| !ENV[v]}
unless undefined.size == 0
  puts "Please define #{required.join(", ")} as environment variables"
  exit 1
end

#export HEROKU_API_KEY=<secret>
#export LEARNERY_THEME=default
#export TRAVIS_TEST_RESULT="0"

if ENV['TRAVIS_TEST_RESULT'] == "0"

  app_name = ARGV[0] ? ARGV[0] : 'learnery-staging'
  puts app_name

  unless 'default' == ENV['LEARNERY_THEME']
    app_name = "#{app_name}-#{ENV['LEARNERY_THEME']}"
  end

  puts "deploying to heroku app #{app_name}"

  HerokuHeadless.configure do | config |
    config.post_deploy_commands = ['rake db:migrate']
  end
  result = HerokuHeadless::Deployer.deploy( app_name )
  exit result ? 0 : 1
end
