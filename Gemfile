
source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0.rc1'

eval(File.read('Gemfile.theme'),binding)

# for travis deploy to learnery-staging
group :test do
  # forked for now because we need this:
  # https://github.com/learnery/heroku-headless/commit/b5179227c710ac84e871b91699fd0fc355d43b28
  gem 'heroku-headless', :git => 'https://github.com/drblinken/heroku-headless.git'
end


# 3.0.0 supports rails 4.0.0
gem 'devise', '3.0.0.rc'
gem 'omniauth-twitter'
gem 'nokogiri'
gem 'redcarpet'


group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'

  # to enable static asset serving for rails4 on heroku
  # https://devcenter.heroku.com/articles/rails4
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'

end


# for travis, see http://about.travis-ci.org/docs/user/languages/ruby/
group :test do
  gem 'rake'
  gem 'minitest-spec-rails'
  gem 'capybara'
  gem 'capybara_minitest_spec'
  gem 'database_cleaner'
end


# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# use redcarpet for markdown
gem 'redcarpet'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

#https://github.com/seyhunak/twitter-bootstrap-rails
gem 'therubyracer'
gem 'less-rails'
gem 'twitter-bootstrap-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
