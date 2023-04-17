require 'px_pay/response/pos/base'

module PxPay
  module Response
    module Pos
      class Pay < Base
        attr_reader :payment_url, :amount, :trade_amount, :discount_amount, :invo_carrier

        def transaction_id
          @mer_trade_no
        end

        def bank_transaction_id
          @px_trade_no
        end

        def pay_tool
          @pay_tool_info.dig('pay_tool')
        end

        def pay_tool_name
          @pay_tool_info.dig('tool_name')
        end

        def pay_tool_identity
          @pay_tool_info.dig('identity')
        end
      end
    end
  end
end
