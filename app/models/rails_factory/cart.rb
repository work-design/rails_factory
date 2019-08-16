module RailsFactory::Cart
  extend ActiveSupport::Concern
  included do
    has_many :customs, dependent: :destroy
  end
end
