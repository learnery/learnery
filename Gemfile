source "https://rubygems.org"

# Declare your gem's dependencies in learnery.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
group :development do
  gem 'debugger'
end

# for travis deploy to learnery-staging
# added here because .gemspec does not support depending on git versions
#http://stackoverflow.com/questions/6499410/ruby-gemspec-dependency-is-possible-have-a-git-branch-dependency
group :test do
  # forked for now because we need this:
  # https://github.com/learnery/heroku-headless/commit/b5179227c710ac84e871b91699fd0fc355d43b28
  gem 'heroku-headless', :git => 'https://github.com/drblinken/heroku-headless.git'
end
group :production do
  # to enable static asset serving for rails4 on heroku
  # https://devcenter.heroku.com/articles/rails4
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end

group :test do
  gem 'rake' # for travis, see http://about.travis-ci.org/docs/user/languages/ruby/
  gem 'minitest-spec-rails'
  gem 'capybara'
  gem 'capybara_minitest_spec'
  gem 'poltergeist'
  gem 'rmagick', :require => 'RMagick'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'factory_girl_rails'
end
