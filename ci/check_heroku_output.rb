#!/usr/bin/env ruby
if ENV['TRAVIS_TEST_RESULT'] == "0"
  #deployed =  open('herokuoutput.log').grep(/Rails app detected/)
  deployed = open('heroku_push_result.log').grep(/true/)
  if deployed.empty?
    puts "deployment failed?"
    exit 1
  else
    exit 0
  end
end
