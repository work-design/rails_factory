require 'rails_com'
module RailsFactory
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir[
      "#{config.root}/app/models/brand",
      "#{config.root}/app/models/component"
    ]

    config.eager_load_paths += Dir[
      "#{config.root}/app/models/brand",
      "#{config.root}/app/models/component"
    ]

    config.generators do |g|
      g.resource_route false
      g.helper false
      g.templates.unshift File.expand_path('lib/templates', RailsCom::Engine.root)
    end

  end # :nodoc:
end
