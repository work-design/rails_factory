module Factory
  module Model::ProductPartTaxon
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :min_select, :integer, default: 1
      attribute :max_select, :integer, default: 1, comment: '最大同时选择，1则为单选'
      attribute :product_parts_count, :integer, default: 0

      belongs_to :product
      belongs_to :part_taxon
      has_many :product_parts, ->(o){ where(part_taxon_id: o.part_taxon_id) }, primary_key: :product_id, foreign_key: :product_id
      has_many :parts, through: :product_parts

      validates :min_select, numericality: { only_integer: true, less_than_or_equal_to: -> (o) { o.product_parts_count } }

      before_validation :sync_name, if: -> { product_id_changed? }
    end

    def sync_name
      self.name = part_taxon.name
    end

    def select_str
      if max_select == min_select
        "必选 #{max_select}"
      elsif max_select > min_select && min_select > 1
        "可选 #{min_select} - #{max_select}"
      elsif max_select > min_select && min_select == 1
        "#{max_select} 选 #{min_select}"
      else
        ""
      end
    end

    def disabled?(production_part_ids, part)
      select_ids = part_ids & production_part_ids
      if parts.size == min_select
        true
      elsif select_ids.size == min_select
        if select_ids.include?(part.id)
          true
        else
          false
        end
      else
        false
      end
    end

  end
end
