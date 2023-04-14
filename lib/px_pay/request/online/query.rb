# frozen_string_literal: true

require 'px_pay/request/online/base'

module PxPay
  module Request
    module Online
      class Query < Base
        attr_writer :order_id, :trade_no_type

        def trade_no_type=(trade_no_type)
          raise ArgumentError, 'trade_no_type must be Merchant or Px' unless %w[Merchant Px].include?(trade_no_type)

          @trade_no_type = trade_no_type
        end

        def trade_no_type
          @trade_no_type || 'Merchant'
        end

        private

        def to_hash
          {}
        end

        def request_action
          'Order'
        end

        def request_type
          :get
        end

        def hash_string
          [trade_no_type, @order_id, @request_time].join
        end

        def end_point
          "#{super}/#{trade_no_type}/#{@order_id}/#{request_time}"
        end
      end
    end
  end
end
