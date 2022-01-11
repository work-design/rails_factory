module Factory
  class Buy::PaymentsController < Buy::BaseController

    def index
    end

    def new
    end

    def create
      @payment = Payment.new
      params[:order]
    end

    # https://pay.weixin.qq.com/wiki/doc/api/native.php?chapter=6_5
    # 二维码有效期为2小时
    def wxpay_pc_pay
      @wxpay_order = @payment.native_order(current_wechat_app)

      if @wxpay_order['code'].present? || @wxpay_order.blank?
        render 'wxpay_pay_err'
      else
        file = QrcodeHelper.code_file @wxpay_order['code_url']
        @blob = ActiveStorage::Blob.build_after_upload io: file, filename: "#{@order.id}"
        if @blob.save
          @image_url = @blob.url
          render 'wxpay_pc_pay'
        else
          render 'wxpay_pay_err', status: :unprocessable_entity
        end
      end
    end


  end
end
