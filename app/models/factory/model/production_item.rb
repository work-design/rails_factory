module Factory
  module Model::ProductionItem
    extend ActiveSupport::Concern

    included do
      attribute :state, :string, default: 'producing'
      attribute :qr_code, :string
      attribute :produced_at, :datetime

      belongs_to :production
      belongs_to :production_plan
      has_many :part_items

      enum state: {
        producing: 'producing',
        receiving: 'receiving',
        warehouse_in: 'warehouse_in',
        warehouse_out: 'warehouse_out',
        used: 'used'
      }

      after_initialize if: :new_record? do
        self.production = self.production_plan.production if production_plan
        self.qr_code ||= UidHelper.nsec_uuid self.production&.qr_code
      end
    end

    def qrcode_url
      QrcodeHelper.data_url(qr_code)
    end

  end
end
