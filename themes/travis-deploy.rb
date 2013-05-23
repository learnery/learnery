#!/usr/bin/env ruby
# this is called by travis ci
require 'heroku-headless'

if 'default' == ENV['LEARNERY_THEME']
  app_name = "learnery-staging"
else
  app_name = "learnery-staging-#{ENV['LEARNERY_THEME']}"
end

puts "deploying to heroku app #{app_name}"

HerokuHeadless.configure do | config |
  config.post_deploy_commands = ['rake db:migrate']
end

HerokuHeadless::Deployer.deploy( app_name )
