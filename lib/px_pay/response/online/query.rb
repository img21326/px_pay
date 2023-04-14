require 'px_pay/response/online/base'

module PxPay
  module Response
    module Online
      class Query < Base
        enum_for :order_type, %w[not_found paid refunded]
        enum_for :pay_status, %w[unpaid paid]
        attr_reader :order_type

        def order_id
          @trade_info.dig('mer_trade_no')
        end

        def bank_transaction_id
          @trade_info.dig('px_trade_no')
        end

        def trade_time
          @trade_info.dig('trade_time')
        end

        def amount
          @trade_info.dig('amount')
        end

        def trade_amount
          @trade_info.dig('trade_amount')
        end

        def discount_amount
          @trade_info.dig('discount_amount')
        end

        def invo_carrier
          @trade_info.dig('invo_carrier')
        end

        def pay_status
          @trade_info.dig('pay_status')
        end

        def pay_tool
          @trade_info.dig('pay_tool_info', 'pay_tool')
        end

        def pay_tool_name
          @pay_tool_info.dig('pay_tool_info', 'tool_name')
        end

        def pay_identity
          @pay_tool_info.dig('pay_tool_info', 'identity')
        end

        def refund_bank_transaction_id
          @trade_info.dig('refund_px_trade_no')
        end
      end
    end
  end
end
