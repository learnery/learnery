#!/usr/bin/env ruby
# this is called by travis ci
require 'heroku-headless'

File.new("travis_job_number","w").write(ENV['TRAVIS_JOB_NUMBER'])

branch =  ENV['TRAVIS_BRANCH']
deploy_only_branch = "master"
if branch != deploy_only_branch
  puts "current branch: (#{branch}) - not on #{deploy_only_branch}, skipping deploy."
  exit 0
end


required = %w(HEROKU_API_KEY LEARNERY_THEME TRAVIS_TEST_RESULT)
undefined = required.select{|v| !ENV[v]}
unless undefined.size == 0
  puts "Please define #{required.join(", ")} as environment variables"
  exit 1
end

#export HEROKU_API_KEY=<secret>
#export LEARNERY_THEME=default
#export TRAVIS_TEST_RESULT="0"

if ENV['TRAVIS_TEST_RESULT'] != "0"
  puts "There were errors in the build - skipping deploy."
else
  if ARGV[0]
    app_name = ARGV[0]
  else
    app_name = 'learnery-staging'
    unless 'default' == ENV['LEARNERY_THEME']
      app_name = "#{app_name}-#{ENV['LEARNERY_THEME']}"
    end
  end

  puts "deploying to heroku app #{app_name}"
  remote_name = "headlessheroku"
  HerokuHeadless.configure do | config |
    config.post_deploy_commands = ['rake db:migrate']
    config.pre_deploy_git_commands = [
      "git remote -v",
      "git config --global user.email \"drblinken@gmail.com\"",
      "git config --global user.name \"Travis CI\"",
      "git checkout master",
      "git commit -am  \"changes from headless deploy\" ",
      "git remote add #{remote_name} git@heroku.com:#{app_name}.git",
      "git fetch #{remote_name}",
      "git merge -m \"merged by automatic deploy\" #{remote_name}/master",
      "git checkout  --ours .",
      "git add . ",
      "git commit -m \" overwrite with new ci version\" "]
  end

  result = HerokuHeadless::Deployer.deploy( app_name )
  puts "successfully deployed to #{app_name}" if result
  exit result ? 0 : 1
end
