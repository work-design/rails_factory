class RenameQrCode < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :qr_code, :qr_prefix
    rename_column :parts, :qr_code, :qr_prefix
  end
end
