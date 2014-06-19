#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require File.expand_path("../config/boot.rb", __FILE__)
require 'rack/mobile-detect'
require 'sinatra/reloader'
require 'dotenv'
Dotenv.load
use Rack::MobileDetect
 
#require these patches from your sinatra/padrino app
module Padrino::Rendering::InstanceMethods
#render foo.mobile.haml if it exists and request is deemed 'mobile', else foo.haml is rendered
#applies for layouts too (application.mobile.haml served for mobile, else application.haml)
def locale
#instead of using I18n.locale, use Rack-Mobile-Detect to try and set a 'mobile' pseudo-locale.
Padrino::Rendering::MOBILE_LOCALE if request_from_mobile_agent?
end
 
def request_from_mobile_agent?
!!env[Rack::MobileDetect::X_HEADER]
end
end
 
module Padrino::Rendering
#the string to use to resolve mobile templates - e.g. foo.mobile.haml
MOBILE_LOCALE = "mobile"
end


map '/' do
  run Blog::App
  
end

run Padrino.application



