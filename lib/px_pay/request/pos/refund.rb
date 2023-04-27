# frozen_string_literal: true

require 'px_pay/request/pos/base'
require 'px_pay/response/pos/refund'
require 'time'

module PxPay
  module Request
    module Pos
      class Refund < Base
        attr_writer :amount

        def store_id=(store_id)
          @store_id = store_id.to_s
        end

        def store_name=(store_name)
          @store_name = store_name.to_s
        end

        def pos_id=(pos_id)
          @pos_id = pos_id.to_s
        end

        def merchant_trade_number=(merchant_trade_number)
          @merchant_trade_number = merchant_trade_number.to_s
        end

        def refund_merchant_trade_number=(refund_merchant_trade_number)
          @refund_merchant_trade_number = refund_merchant_trade_number.to_s
        end

        def px_trade_no=(px_trade_no)
          @px_trade_no = px_trade_no.to_s
        end

        private

        def response_klass
          PxPay::Response::Pos::Refund
        end

        def to_hash
          super.merge(
            store_id: @store_id,
            store_name: @store_name,
            pos_id: @pos_id,
            pos_trade_time: @trade_time,
            ori_mer_trade_no: @merchant_trade_number,
            mer_trade_no: @refund_merchant_trade_number,
            ori_px_trade_no: @px_trade_no,
            none_discount_amount: 0,
            none_feedback_amount: 0,
            amount: @amount
          )
        end

        def request_action
          'Refund'
        end

        def hash_string
          [@store_id, @pos_id, @trade_time, @merchant_trade_number, @refund_merchant_trade_number, @amount,
           request_time].join
        end
      end
    end
  end
end
