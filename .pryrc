load %{./config/boot.rb}
load %{./config/database.rb}
load %{./config/apps.rb}
require 'padrino-core/cli/console'
require 'padrino-core/cli/adapter'
require 'padrino-core/cli/base'
require 'padrino-core/cli/rake'
require 'padrino-core/cli/rake_tasks'

def app
  Padrino.application
end

def start( server = :puma )
  puts %{Type Ctrl-C to background server}
  Padrino.run! server: server
rescue Exception => e
  puts %{Problem starting server: #{ e.to_s }}
end

def stop
  puts %{Stopping server}
  threads = Thread.list
  threads.shift
  threads.each { |t| Thread.kill t }
end

def save_to( file, contents )
  File.open( file, %{w} ) { |f| f.puts contents }
end
Pry.config.theme = "railscasts"

