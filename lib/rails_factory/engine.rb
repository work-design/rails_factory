require 'rails_com'
class RailsFactory::Engine < ::Rails::Engine

  config.eager_load_paths += Dir[
    "#{config.root}/app/models/rails_factory"
  ]

  config.generators do |g|
    g.rails = {
      assets: false,
      stylesheets: false,
      helper: false
    }
    g.test_unit = {
      fixture: true,
      fixture_replacement: :factory_bot
    }
    g.templates.unshift File.expand_path('lib/templates', RailsCom::Engine.root)
  end

  initializer 'rails_factory.assets.precompile' do |app|
    app.config.assets.precompile += ['rails_factory_manifest.js']
  end

end # :nodoc:
