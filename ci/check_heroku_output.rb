#!/usr/bin/env ruby
if ENV['TRAVIS_TEST_RESULT'] == "0"
  deployed =  open('herokuoutput.log').grep(/Rails app detected/)
  if deployed.empty?
    puts "could not find 'Rails app detected' in heroku output - deployment failed?"
    exit 1
  else
    exit 0
  end
end
