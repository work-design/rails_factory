module Factory
  module Model::ProductTaxon
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :position, :integer
      attribute :products_count, :integer, default: 0
      attribute :enabled, :boolean, default: true

      belongs_to :template, class_name: 'JiaBo::Template', optional: true

      belongs_to :organ, optional: true
      belongs_to :factory_taxon, optional: true
      belongs_to :scene, optional: true

      has_many :products, dependent: :nullify

      has_one_attached :logo

      scope :enabled, -> { where(enabled: true)}

      acts_as_list scope: :organ_id
    end

  end
end
