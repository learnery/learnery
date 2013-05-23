#!/usr/bin/env ruby
require 'heroku-headless'
puts "ENV[\"BUNDLE_GEMFILE\"]"
puts ENV["BUNDLE_GEMFILE"]
puts ENV["BUNDLE_GEMFILE"].inspect
gf = ENV["BUNDLE_GEMFILE"]
if gf == "Gemfile" || gf == "" || gf == nil
  HerokuHeadless.configure do | config |
    config.post_deploy_commands = [
      'rake db:migrate'
    ]
  end
  HerokuHeadless::Deployer.deploy( 'learnery-staging' )
end
