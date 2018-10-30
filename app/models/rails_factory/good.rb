class Good < ApplicationRecord

end unless RailsFactory.config.disabled_models.include?('Good')
