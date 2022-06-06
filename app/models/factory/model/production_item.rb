module Factory
  module Model::ProductionItem
    extend ActiveSupport::Concern

    included do
      attribute :qr_code, :string
      attribute :came_at, :datetime, default: -> { Time.current }

      belongs_to :production
      belongs_to :production_plan, counter_cache: true
      belongs_to :product_item, optional: true

      has_many :part_items

      enum state: {
        purchased: 'purchased',
        produced: 'produced',
        received: 'received',
        warehouse_in: 'warehouse_in',
        grid_in: 'grid_in',
        grid_out: 'grid_out',
        warehouse_out: 'warehouse_out',
        used: 'used'
      }, _default: 'purchased'

      after_initialize if: :new_record? do
        self.production = self.production_plan.production if production_plan
        self.qr_code ||= UidHelper.nsec_uuid self.production&.qr_code
      end
    end

    def qrcode_url
      QrcodeHelper.data_url(qr_code)
    end

    def enter_url
      Rails.application.routes.url_for(controller: 'factory/me/production_items', action: 'qrcode', id: self.id)
    end

    def qrcode_enter_url
      QrcodeHelper.data_url(enter_url)
    end

    def to_cpcl
      cpcl = BaseCpcl.new
      cpcl.text production.name
      cpcl.text qr_code
      cpcl.right_qrcode(enter_url)
      cpcl.render
    end

    def to_pdf
      pdf = BasePdf.new
      pdf.text production.name
      pdf.text qr_code
      pdf
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
