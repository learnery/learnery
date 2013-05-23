require 'heroku-headless'
HerokuHeadless.configure do | config |
  config.post_deploy_commands = [
    'rake db:migrate'
  ]
end
HerokuHeadless::Deployer.deploy( 'learnery-staging' )
