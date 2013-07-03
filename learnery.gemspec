$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "learnery/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "learnery"
  s.version     = Learnery::VERSION
  s.authors     = ["Brigitte Jellinek, Barbara Kleinen"]
  s.email       = ["me@brigitte-jellinek.at"]
  s.homepage    = "https://github.com/learnery/learnery"
  s.summary     = "a mountable rails engine for manging learning events like user groups, barcamps or rails bridge"
  s.description = "create events with dates and venues, users can suggest topics, vote on topics, rsvp."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_dependency 'devise', '3.0.0.rc'
  s.add_dependency 'omniauth-twitter'
  s.add_dependency 'omniauth-github'
  s.add_dependency 'omniauth-steam'
  s.add_dependency 'nokogiri'
  s.add_dependency 'redcarpet'
  s.add_dependency 'state_machine'
  s.add_dependency 'twitter-bootstrap-rails'
  #https://github.com/seyhunak/twitter-bootstrap-rails
  s.add_dependency 'therubyracer'
  s.add_dependency 'less-rails'

  # rails dependencies
  s.add_dependency 'sass-rails', '~> 4.0.0'
  s.add_dependency 'uglifier', '>= 1.3.0'
  s.add_dependency 'coffee-rails', '~> 4.0.0'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'turbolinks'
  s.add_dependency 'jbuilder', '~> 1.2'

  # production group
  s.add_dependency   'pg'

  s.add_development_dependency "sqlite3"

  # group :test do
  s.add_dependency 'rake' # for travis, see http://about.travis-ci.org/docs/user/languages/ruby/
  s.add_dependency 'minitest-spec-rails'
  s.add_dependency 'capybara'
  s.add_dependency 'capybara_minitest_spec'
  s.add_dependency 'poltergeist'
  s.add_dependency 'rmagick' #, :require => 'RMagick'
  s.add_dependency 'database_cleaner'
  s.add_dependency 'launchy'
  s.add_dependency 'factory_girl_rails'


end
