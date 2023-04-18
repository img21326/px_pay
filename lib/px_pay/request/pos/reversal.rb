# frozen_string_literal: true

require 'px_pay/request/pos/base'
require 'px_pay/response/pos/reversal'

module PxPay
  module Request
    module Pos
      class Reversal < Base
        def store_id=(store_id)
          @store_id = store_id.to_s
        end

        def store_name=(store_name)
          @store_name = store_name.to_s
        end

        def pos_id=(pos_id)
          @pos_id = pos_id.to_s
        end

        def trade_time=(trade_time)
          if trade_time.instance_of? Time
            @trade_time = trade_time.strftime('%Y%m%d%H%M%S')
          elsif trade_time.instance_of? String
            @trade_time = Time.parse(trade_time).strftime('%Y%m%d%H%M%S')
          else
            raise ArgumentError, 'trade_time must be Time or String'
          end
        end

        def transaction_id=(transaction_id)
          @transaction_id = transaction_id.to_s
        end

        attr_writer :pay_token, :amount

        private

        def to_hash
          super.merge(
            store_id: @store_id,
            store_name: @store_name,
            pos_id: @pos_id,
            pos_trade_time: @trade_time,
            mer_trade_no: @transaction_id,
            pay_token: @pay_token,
            amount: @amount
          )
        end

        def response_klass
          PxPay::Response::Pos::Reversal
        end

        def request_action
          'Reversal'
        end

        def request_type
          :post
        end

        def hash_string
          [@store_id, @pos_id, @trade_time, @transaction_id, @pay_token, @amount, request_time].join
        end
      end
    end
  end
end
