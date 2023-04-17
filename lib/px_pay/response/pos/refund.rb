require 'px_pay/response/online/base'

module PxPay
  module Response
    module Online
      class Refund < Base
        attr_reader :amount, :discount_amount, :trade_amount, :invo_carrier

        def transaction_id
          @mer_trade_no
        end

        def bank_transaction_id
          @px_trade_no
        end

        def refund_bank_transaction_id
          @refund_px_trade_no
        end

        def trade_time
          @trade_time = Time.parse(@trade_time) if @trade_time.instance_of? String
        end
      end
    end
  end
end
