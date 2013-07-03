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
