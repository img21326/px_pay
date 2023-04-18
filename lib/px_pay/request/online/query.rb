# frozen_string_literal: true

require 'px_pay/request/online/base'
require 'px_pay/response/online/query'

module PxPay
  module Request
    module Online
      class Query < Base
        def transaction_id=(transaction_id)
          @transaction_id = transaction_id.to_s
        end

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

        def response_klass
          PxPay::Response::Online::Query
        end

        def request_action
          'Order'
        end

        def request_type
          :get
        end

        def hash_string
          [trade_no_type, @transaction_id, request_time].join
        end

        def end_point
          "#{super}/#{trade_no_type}/#{@transaction_id}/#{request_time}"
        end
      end
    end
  end
end
