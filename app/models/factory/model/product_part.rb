module Factory
  module Model::ProductPart
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :min_select, :integer, default: 1
      attribute :max_select, :integer
      attribute :default, :boolean, default: false
      attribute :production_parts_count, :integer, default: 0

      belongs_to :product, counter_cache: true
      belongs_to :part, class_name: 'Product'
      belongs_to :part_taxon, class_name: 'ProductTaxon'
      belongs_to :product_part_taxon, ->(o) { where(part_taxon_id: o.part_taxon_id) }, foreign_key: :product_id, primary_key: :product_id, counter_cache: true

      validates :part_id, uniqueness: { scope: :product_id }

      before_validation :sync_part_taxon, on: :create
    end

    def sync_part_taxon
      self.part_taxon_id = self.part.product_taxon_id
    end

    def select_str
      if max_select == min_select && production_parts_count > max_select.to_i
        "#{production_parts_count} 选 #{max_select}"
      elsif max_select == min_select && production_parts_count == max_select
        "必选 #{max_select}"
      elsif max_select.to_i > min_select.to_i
        "可选 #{min_select} - #{max_select}"
      else
        ""
      end
    end

    def only_one?
      max_select == min_select && max_select == 1 && production_parts_count > max_select
    end

    def disabled?(production_part_ids, part)
      select_ids = part_ids & production_part_ids

      return false if only_one?
      return true if select_ids.size == min_select && select_ids.include?(part.id)
      return true if select_ids.size == max_select && select_ids.exclude?(part.id)

      false
    end

  end
end
