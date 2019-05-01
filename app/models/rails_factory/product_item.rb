module RailsFactory::ProductItem
  extend ActiveSupport::Concern
  included do
    attribute :state, :string, default: 'producing'
  
    belongs_to :product
    has_many :part_items
  
    has_one_attached :qr_file
  
    enum state: {
      producing: 'producing',
      receiving: 'receiving',
      warehouse_in: 'warehouse_in',
      warehouse_out: 'warehouse_out',
      used: 'used'
    }
  
    after_initialize if: :new_record? do
      self.qr_code ||= UidHelper.nsec_uuid self.product&.qr_prefix
    end
    before_save :sync_qrcode, if: -> { qr_code_changed? }
  end
  
  def sync_qrcode
    file = QrcodeHelper.code_file(qr_code)
    file.rewind
    self.qr_file.attach io: file, filename: qr_code
  end

end
