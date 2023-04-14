require 'px_pay/response/online/base'

module PxPay
  module Response
    module Online
      class Refund < Base
        attr_reader :amount, :discount_amount, :trade_time

        def order_id
          @mer_trade_no
        end

        def bank_transaction_id
          @px_trade_no
        end

        def refund_bank_transaction_id
          @refund_px_trade_no
        end

        def refund_amount
          @trade_amount
        end
      end
    end
  end
end
