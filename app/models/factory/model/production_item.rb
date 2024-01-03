module Factory
  module Model::ProductionItem
    extend ActiveSupport::Concern

    included do
      attribute :code, :string
      attribute :amount, :decimal, default: 1
      attribute :came_at, :datetime, default: -> { Time.current }

      belongs_to :production
      belongs_to :production_plan, counter_cache: true, optional: true
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

      after_initialize :init_code, if: :new_record?
    end

    def init_code
      self.production = self.production_plan.production if production_plan
      self.code ||= UidHelper.nsec_uuid(production&.qr_code)
    end

    def qrcode_url
      QrcodeHelper.data_url(code)
    end

    def enter_url
      Rails.application.routes.url_for(controller: 'factory/me/production_items', action: 'qrcode', id: self.id)
    end

    def qrcode_enter_url
      QrcodeHelper.data_url(enter_url)
    end

    def qrcode_enter_png
      QrcodeHelper.code_png(enter_url, border_modules: 0, fill: 'pink')
    end

    def to_cpcl
      cpcl = BaseCpcl.new
      cpcl.text production.name
      cpcl.text code
      cpcl.right_qrcode(enter_url)
      cpcl.render
    end

    def to_tspl
      ts = BaseTspl.new
      ts.text production.name, x: 20
      ts.text code, x: 20
      ts.qrcode(enter_url)
      ts.render
    end

    def to_pdf
      pdf = BasePdf.new(width: 80.mm, height: 50.mm)
      pdf.text production.name
      pdf.text code
      pdf.text 'dddd'
      pdf.text 'rrrr'
      pdf.bounding_box([pdf.bounds.right - 60, pdf.bounds.top], width: 60, height: 60) do
        pdf.image StringIO.new(qrcode_enter_png.to_blob), fit: [60, 60], position: :right, vposition: :top
      end
      pdf
    end

    def print
      production.organ.device.print(
        data: to_tspl
      )
    end

  end
end
