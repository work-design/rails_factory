module Factory
  module Model::ProductTaxon
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :position, :integer
      attribute :take_stock, :boolean, comment: '可盘点'
      attribute :products_count, :integer, default: 0
      attribute :enabled, :boolean, default: true
      attribute :partial, :boolean, default: false

      belongs_to :template, class_name: 'JiaBo::Template', optional: true

      belongs_to :organ, optional: true
      belongs_to :factory_taxon, optional: true
      belongs_to :scene, optional: true

      has_many :products, dependent: :nullify

      has_one_attached :logo

      default_scope -> { order(position: :asc) }
      scope :enabled, -> { where(enabled: true)}

      acts_as_list scope: :organ_id
    end

  end
end
