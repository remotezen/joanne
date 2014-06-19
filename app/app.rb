module Blog
 class App < Padrino::Application
  require 'geocoder'

  require 'will_paginate-bootstrap'
  require "geocoder/railtie"
  Geocoder::Railtie.insert
  register WillPaginate::Sinatra
  #register Sinatra::Contrib
  register SassInitializer
  use ActiveRecord::ConnectionAdapters::ConnectionManagement
  register Sinatra::Twitter::Bootstrap::Assets
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  #register Padrino::Admin::AccessControl
  register Padrino::Flash
  register Padrino::Cookies
  register Padrino::FormErrors
  register Padrino::Warden
  register Padrino::Warden::Helpers
  register Padrino::Cache
  register Padrino::Cache::Helpers::CacheStore
  register Padrino::Cache::Helpers::Fragment
  register Padrino::Cache::Helpers::Page
  require 'agent_orange'
#  register PadrinoFields
  #set :default_builder, 'PadrinoFieldsBuilder'
  require 'squeel'
Padrino.cache.parser = :marshal
use Rack::Recaptcha, :public_key =>'6LepqPISAAAAAPeBSlBCuBT0xCVBS8GX1Mzd7xS1',
:private_key => '6LepqPISAAAAADdnLHdHjpD-BYA0qSGkubX8ET_g' 
helpers Rack::Recaptcha::Helpers
#set :session_key => 'jo'

enable :caching
use Rack::Session::Cookie, :key => 'jo.session',
                           :path => '/',
                           :secret => '6LepqPISAAAAADdnLHdHjpD-BYA0qSGkubX8ET_g',
                           :expire => 1.year     
#Padrino.cache = Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
#set :cache, Padrino::Cache::Store::Redis.new(::Redis.new)
 #set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))

#Padrino.cache = Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
=begin
  require 'encrypted_cookie'
  use Rack::Session::EncryptedCookie,
  :secret => '9697d1d20c97b8abb62f2305b825fb864d64378ddb4dab771a724019dfa2bcab'
=end
  #require 'sprockets'
  #register Padrino::Sprockets
=begin
  register Padrino::Pipeline
  configure_assets do |config|
    config.pipeline = Padrino::Pipeline::Sprockets
  end
=end  
  #sprockets :minify => (Padrino.env == :production)
  #register SprocketsInitializer unless Padrino.env == :production
  #helpers Sprockets::Helpers
# enable js minification
  require 'will_paginate/array'
  #register Blog::Admin
#  register Padrino::Warden
   # require 'rack-ssl-enforcer'
    #use Rack::SslEnforcer


require 'dotenv'
Dotenv.load
=begin
require 'thinking-sphinx'
ActiveSupport.on_load :active_record do
include ThinkingSphinx::ActiveRecord
end
=end
require 'will_paginate'
#set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1,:expires_in=>0))
#dc.set('abc', 123)
#value = dc.get('abc')
#
    ##
    # Caching support.
    #
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
     Padrino.cache =  Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
     #set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
    # set :cache, Padrino::Cache::Store::Memory.new(50)
    # set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
     set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
     layout  :application            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)

    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #

       

       error 404 do
         render 'errors/404'
       end
    #
       error 505 do
         render 'errors/505'
       end
    #
     #
    error(403) { @title = "Error 403"; render('errors/403', :layout => :error) }
    error(404) { @title = "Error 404"; render('errors/404', :layout => :error) }
    error(500) { @title = "Error 500"; render('errors/500', :layout => :error) }
    before do
    end

  end
end
