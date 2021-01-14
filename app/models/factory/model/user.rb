module RailsFactory::User
  extend ActiveSupport::Concern

  included do
    has_many :productions, dependent: :destroy
  end

end
