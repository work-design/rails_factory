module Factory
  module Model::ProductionItem
    extend ActiveSupport::Concern

    included do
      attribute :qr_code, :string
      attribute :produced_at, :datetime, default: -> { Time.current }

      belongs_to :production
      belongs_to :production_plan, counter_cache: true
      has_many :part_items

      enum state: {
        produced: 'produced',
        received: 'received',
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

    def print
      device = JiaBo::Device.first
      template = JiaBo::Template.first
      data = {
        name: production.name,
        price: production.price,
        qrcode: qr_code,
        customer: 'test'
      }

      device.templet_print(msg_no: qr_code, template_id: template.code, data: data)
    end

  end
end
