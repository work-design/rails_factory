module Factory
  class Buy::PaymentsController < Buy::BaseController
    before_action :set_payment, only: [:wxpay_pc_pay]

    def index
    end

    def new
    end

    def create
      @payment = Trade::Payment.new(organ_id: params[:organ_id], type: params[:type])
      @payment.total_amount = current_organ.member_orders.sum(:amount)

      current_organ.member_orders.each do |order|
        @payment.payment_orders.build(order_id: order.id)
      end

      @payment.save
    end

    # https://pay.weixin.qq.com/wiki/doc/api/native.php?chapter=6_5
    # 二维码有效期为2小时
    def wxpay_pc_pay
      @wxpay_order = @payment.native_order(current_wechat_app)

      if @wxpay_order['code'].present? || @wxpay_order.blank?
        render 'wxpay_pay_err'
      else
        file = QrcodeHelper.code_file @wxpay_order['code_url']
        @blob = ActiveStorage::Blob.build_after_upload io: file, filename: "#{@payment.id}"
        if @blob.save
          @image_url = @blob.url
          render 'wxpay_pc_pay'
        else
          render 'wxpay_pay_err', status: :unprocessable_entity
        end
      end
    end

    private
    def current_wechat_app
      organ_domain = Org::OrganDomain.find_by(organ_id: params[:organ_id], default: true)
      organ_domain&.wechat_app
    end

    def set_payment
      @payment = Trade::Payment.find params[:id]
    end

  end
end
