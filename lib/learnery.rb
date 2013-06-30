
require 'rubygems'

require 'omniauth-twitter'
require 'omniauth-github'
require 'omniauth-steam'


require 'nokogiri'
require 'redcarpet'
require 'state_machine'
#require 'therubyracer'
require 'less-rails'

require 'sass-rails'
require 'uglifier'
require 'coffee-rails'
require 'jquery-rails'
require 'turbolinks'
require 'jbuilder'

require 'devise'
require 'learnery/engine'
require 'twitter-bootstrap-rails'



Bundler.require(:default, Rails.env)
module Learnery
end
