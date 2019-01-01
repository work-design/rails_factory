class CustomPart < ApplicationRecord
  belongs_to :custom
  belongs_to :part

end unless RailsFactory.config.disabled_models.include?('CustomPart')
