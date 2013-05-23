#!/usr/bin/env ruby
require 'heroku-headless'

unless /learnery\/Gemfile$/.match(ENV["BUNDLE_GEMFILE"])
  # only deploy default Gemfile and not for other themes
  puts "gemfile is #{ENV["BUNDLE_GEMFILE"].inspect} - skipping deploy"
else
  HerokuHeadless.configure do | config |
    config.post_deploy_commands = [
      'rake db:migrate'
    ]
  end
  HerokuHeadless::Deployer.deploy( 'learnery-staging' )
end
