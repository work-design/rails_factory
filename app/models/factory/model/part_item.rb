module Factory
  module Model::PartItem
    extend ActiveSupport::Concern

    included do
      attribute :qr_code, :string
      attribute :received_at, :datetime

      enum state: {
        purchasing: 'purchasing',
        receiving: 'receiving',
        warehouse_in: 'warehouse_in',
        warehouse_out: 'warehouse_out',
        used: 'used'
      }, _default: 'purchasing'

      belongs_to :part
      belongs_to :product_item, optional: true
      has_one_attached :qr_file

      after_initialize if: :new_record? do
        self.qr_code ||= UidHelper.nsec_uuid self.part&.qr_prefix
      end
      before_save :sync_qrcode, if: -> { qr_code_changed? }
    end

    def sync_qrcode
      file = QrcodeHelper.code_file(qr_code)
      file.rewind
      self.qr_file.attach io: file, filename: qr_code
    end

  end
end
