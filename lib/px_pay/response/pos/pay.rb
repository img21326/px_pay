require 'px_pay/response/pos/base'

module PxPay
  module Response
    module Pos
      class Pay < Base
        attr_reader :payment_url, :amount, :trade_amount, :discount_amount, :invo_carrier

        def bank_transaction_id
          @px_trade_no
        end

        def trade_time
          @trade_time = Time.parse(@px_trade_time) if @px_trade_time.instance_of? String
        end

        def pay_tool
          @pay_tool_info.dig('pay_tool')
        end

        def pay_tool_name
          @pay_tool_info.dig('tool_name')
        end

        def identity
          @pay_tool_info.dig('identity')
        end
      end
    end
  end
end
