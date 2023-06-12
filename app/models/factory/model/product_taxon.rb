module Factory
  module Model::ProductTaxon
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :position, :integer
      attribute :take_stock, :boolean, comment: '可盘点'
      attribute :enabled, :boolean, default: true
      attribute :partial, :boolean, default: false, comment: '可作为配件'
      attribute :nav, :boolean, default: false, comment: '单独分类'
      attribute :products_count, :integer, default: 0
      attribute :provides_count, :integer, default: 0

      belongs_to :template, class_name: 'JiaBo::Template', optional: true

      belongs_to :organ, optional: true
      belongs_to :factory_taxon, optional: true
      belongs_to :scene, optional: true

      has_many :products
      has_many :productions
      has_many :provides
      has_many :providers, through: :provides

      has_one_attached :logo
      has_one_attached :logo_color

      default_scope -> { order(position: :asc) }
      scope :enabled, -> { where(enabled: true, nav: false)}
      scope :nav, -> { where(enabled: true, nav: true) }

      acts_as_list scope: :organ_id
    end

  end
end
