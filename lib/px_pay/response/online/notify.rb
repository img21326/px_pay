require 'px_pay/response/online/base'

module PxPay
  module Response
    module Online
      class Notify < Base
        def sign_value
          @raw.headers['PX-SignValue']
        end

        def order_id
          @mer_trade_no
        end

        def bank_transaction_id
          @transaction_id
        end

        attr_reader :px_trade_no, :amount, :trade_amount, :discount_amount, :invo_carrier

        def trade_time
          @trade_time = Time.parse(@trade_time) if @trade_time.instance_of? String
        end

        def pay_tool
          @pay_tool_info.dig('pay_tool')
        end

        def pay_tool_name
          @pay_tool_info.dig('tool_name')
        end

        def pay_identity
          @pay_tool_info.dig('identity')
        end

        def request_time
          @req_time
        end
      end
    end
  end
end
