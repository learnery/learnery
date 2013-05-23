require 'heroku-headless'
HerokuHeadless.configure do | config |
end
HerokuHeadless::Deployer.deploy( 'learnery-staging' )
