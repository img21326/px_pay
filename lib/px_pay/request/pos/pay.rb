# frozen_string_literal: true

require 'px_pay/request/pos/base'

module PxPay
  module Request
    module Online
      class Pay < Base
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

        attr_writer :pay_token, :amount, :remark1, :remark2, :remark3

        private

        def to_hash
          super.merge(
            store_id: @store_id,
            store_name: @store_name,
            pos_id: @pos_id,
            pos_trade_time: @trade_time,
            mer_trade_no: @transaction_id,
            pay_token: @pay_token,
            amount: @amount,
            none_discount_amount: 0,
            none_feedback_amount: 0,
            remark1: @remark1 || '',
            remark2: @remark2 || '',
            remark3: @remark3 || '',
            marketing: [],
            products: []
          )
        end

        def response_klass
          PxPay::Response::Pos::Pay
        end

        def request_action
          'Payment'
        end

        def request_type
          :post
        end

        def hash_string
          [@store_id, @pos_id, @trade_time, @order_id, @pay_token, @amount, request_time].join
        end
      end
    end
  end
end
