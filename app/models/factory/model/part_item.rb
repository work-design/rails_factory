module Factory
  module Model::PartItem
    extend ActiveSupport::Concern

    included do
      attribute :qr_code, :string
      attribute :received_at, :datetime, default: -> { Time.current }

      enum state: {
        purchased: 'purchased',
        received: 'received',
        warehouse_in: 'warehouse_in',
        warehouse_out: 'warehouse_out',
        used: 'used'
      }, _default: 'purchased'

      belongs_to :part
      belongs_to :product_item, optional: true

      after_initialize if: :new_record? do
        self.qr_code ||= UidHelper.nsec_uuid self.part&.qr_prefix
      end
    end

    def qrcode_url
      QrcodeHelper.data_url(qr_code)
    end

  end
end
