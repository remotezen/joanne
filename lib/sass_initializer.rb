module SassInitializer
  def self.registered(app)
    require 'sass/plugin/rack'
    Sass::Plugin.options[:template_location] = Padrino.root("app/stylesheets")
    Sass::Plugin.options[:css_location] = Padrino.root("public/stylesheets")
    app.use Sass::Plugin::Rack
  end
  def setup_stylesheet
    require_dependencies 'sass'
    initializer :scss, SCSS_INIT.chomp
    empty_directory destination_root('/app/stylesheets')
  end
end
