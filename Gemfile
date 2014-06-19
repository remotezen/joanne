#thin start -p 3001 --ssl --ssl-key-file /public/ssl/server.key --ssl-cert-file /public/ssl/server.crt  
#bundle exec puma -e 'production'  -b 'ssl://127.0.0.1:9292?key=public/ssl/server.key&cert=public/ssl/server.crt'
#bundle exec puma -b 'ssl://127.0.0.1:9292?key=public/ssl/server.key&cert=public/ssl/server.crt' 
source 'https://rubygems.org'
#source 'http://production.cf.rubygems.org' 
#bundle exec puma -e production -b 'ssl://127.0.0.1:9292?key=/etc/ssl/server.key&cert=/etc/ssl/server.crt' 
# pry -I . -r app/app.rb 


gem 'rake', '>=10.2.2'
gem 'omniauth'
# Component requirements
gem 'bcrypt-ruby', :require => 'bcrypt'
gem 'agent_orange'
gem 'will_paginate', '~>3.0'
gem 'haml'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'padrino-form-errors'
#gem 'sqlite3'
gem 'pg'
# Test requirements
gem 'shoulda', :group => 'test'
gem 'rack-test', :require => 'rack/test', :group => 'test'
gem 'squeel'
gem 'activerecord-postgresql-adapter'

# Padrino Stable Gem
gem 'padrino', '0.11.4'
gem 'carrierwave'
gem  'mini_magick'
group :development, :test do
  gem 'tux'
  gem 'ffaker'
  gem 'pry'
  gem 'pry-padrino'
  gem 'pry-theme'
  gem 'pry-nav'
end
gem 'sass', ' ~> 3.2.0'
gem "sinatra-contrib"
gem 'rack-mobile-detect' 
gem 'sinatra-twitter-bootstrap', :require => 'sinatra/twitter-bootstrap'
gem 'ripl-rack', '~>0.2.1'
gem 'padrino-warden'
gem 'padrino-flash'
gem 'dotenv'
gem 'bcrypt'
#gem 'thinking-sphinx', '~> 3.0.2',
#  :require => 'thinking_sphinx/sinatra'
gem 'padrino-contrib'
gem 'kgio'
gem 'dalli'
gem 'fistface'
gem 'padrino-cookies'
gem 'rack-ssl-enforcer'
gem 'geocoder'
gem 'will_paginate-bootstrap'
#gem 'sprockets', '~>2.10.0'
#gem 'padrino-sprockets', :require => ['padrino/sprockets'], :git => 'git://github.com/nightsailer/padrino-sprockets.git'
#gem 'padrino-assets'
#gem 'padrino-assets'
#gem 'padrino-pipeline'
gem 'puma'
gem 'foreman'
# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# enable css compression
  gem 'uglifier', '~> 2.1.0'
 # gem 'padrino-sprockets', :require => "padrino/sprockets"
  gem 'yui-compressor'
  gem 'encrypted_cookie'
  #gem 'thinking-sphinx'
  gem 'rack-recaptcha', :require => 'rack/recaptcha'

