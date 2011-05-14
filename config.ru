require 'rubygems'
require 'bundler'

Bundler.require

use Rack::Static, :urls => ['/stylesheets', '/javascripts', '/data.json'], :root => 'public'

require File.dirname(__FILE__) + '/app'
run LMApi
