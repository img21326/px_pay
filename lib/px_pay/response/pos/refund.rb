require 'px_pay/response/pos/base'

module PxPay
  module Response
    module Pos
      class Refund < Base
        attr_reader :amount, :discount_amount, :trade_amount, :invo_carrier

        def transaction_id
          @mer_trade_no
        end

        def bank_transaction_id
          @px_trade_no
        end
      end
    end
  end
end
