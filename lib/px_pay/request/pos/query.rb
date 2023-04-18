# frozen_string_literal: true

require 'px_pay/request/pos/base'
require 'px_pay/response/pos/query'

module PxPay
  module Request
    module Pos
      class Query < Base
        attr_writer :transaction_id, :trade_no_type

        def trade_no_type=(trade_no_type)
          case trade_no_type
          when :Merchant
            @trade_no_type = 1
          when :Gateway
            @trade_no_type = 2
          when :Px
            @trade_no_type = 3
          else
            raise ArgumentError, 'trade_no_type must be Merchant or Px'
          end
        end

        def trade_no_type
          @trade_no_type || 1
        end

        private

        def response_klass
          PxPay::Response::Pos::Query
        end

        def to_hash
          {}
        end

        def request_action
          'OrderStatus'
        end

        def request_type
          :get
        end

        def hash_string
          [trade_no_type, @transaction_id, @request_time].join
        end

        def end_point
          "#{super}/#{trade_no_type}/#{@transaction_id}/#{request_time}"
        end
      end
    end
  end
end
