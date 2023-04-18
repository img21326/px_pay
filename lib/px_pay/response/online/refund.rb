require 'px_pay/response/online/base'

module PxPay
  module Response
    module Online
      class Refund < Base
        attr_reader :amount, :discount_amount, :trade_amount, :px_trade_no, :refund_px_trade_no

        def transaction_id
          @mer_trade_no
        end

        def refund_transaction_id
          @refund_mer_trade_no
        end

        def trade_time
          @trade_time = Time.parse(@trade_time) if @trade_time.instance_of? String
        end
      end
    end
  end
end
