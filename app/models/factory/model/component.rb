module Factory
  module Model::Component
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :name, :string
      attribute :min_select, :integer, default: 1
      attribute :max_select, :integer
      attribute :component_parts_count, :integer, default: 0

      belongs_to :part_taxon, class_name: 'Taxon'

      has_many :component_parts
      has_many :parts, through: :component_parts

      validates :min_select, numericality: { only_integer: true, less_than_or_equal_to: -> (o) { o.max_select } }
      #validates :max_select, numericality: { only_integer: true, less_than_or_equal_to: -> (o) { o.product_parts_count } }

    end

    def select_str
      if max_select == min_select && product_parts_count > max_select.to_i
        "#{product_parts_count} 选 #{max_select}"
      elsif max_select == min_select && product_parts_count == max_select
        "必选 #{max_select}"
      elsif max_select.to_i > min_select.to_i
        "可选 #{min_select} - #{max_select}"
      else
        ''
      end
    end

    def only_one?
      max_select == min_select && max_select == 1 && product_parts_count > max_select
    end

    def disabled?(production_part_ids, part_id)
      select_ids = part_ids & production_part_ids

      return select_ids.all?(part_id) if only_one?
      return true if select_ids.size == min_select && select_ids.include?(part_id)
      return true if select_ids.size == max_select && select_ids.exclude?(part_id)

      false
    end

    def cancelable?(production_part_ids, part_id)
      select_ids = part_ids & production_part_ids

      return false if only_one?
      select_ids.include?(part_id)
    end

  end
end
