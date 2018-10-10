class RailsFactory::Engine < ::Rails::Engine

  config.eager_load_paths += Dir[
    "#{config.root}/app/models/rails_factory",
    "#{config.root}/app/models/rails_factory/concerns",
  ]

  config.generators do |g|
    g.rails = {
      assets: false,
      stylesheets: false,
      helper: false
    }
    g.test_unit = {
      fixture: true,
      fixture_replacement: :factory_girl
    }
  end

  initializer 'rails_factory.assets.precompile' do |app|
    app.config.assets.precompile += ['rails_factory_manifest.js']
  end

end # :nodoc:
