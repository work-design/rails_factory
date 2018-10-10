module QrcodeHelper
  extend self

  def code_file(url)
    qrcode = RQRCode::QRCode.new(url)
    png = qrcode.as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: 'white',
      color: 'black',
      size: 300,
      border_modules: 4,
      module_px_size: 6,
      file: nil
    )
    tmp = Tempfile.new
    tmp.binmode
    tmp.write png.to_s
    tmp
  end

end


