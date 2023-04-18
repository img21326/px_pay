# frozen_string_literal: true

require 'px_pay/request/pos/base'
require 'px_pay/response/pos/refund'
require 'time'

module PxPay
  module Request
    module Pos
      class Refund < Base
        attr_writer :amount, :remark1, :remark2, :remark3

        def store_id=(store_id)
          @store_id = store_id.to_s
        end

        def store_name=(store_name)
          @store_name = store_name.to_s
        end

        def pos_id=(pos_id)
          @pos_id = pos_id.to_s
        end

        def transaction_id=(transaction_id)
          @transaction_id = transaction_id.to_s
        end

        def refund_transaction_id=(refund_transaction_id)
          @refund_transaction_id = refund_transaction_id.to_s
        end

        def bank_transaction_id=(bank_transaction_id)
          @bank_transaction_id = bank_transaction_id.to_s
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
            ori_mer_trade_no: @transaction_id,
            mer_trade_no: @refund_transaction_id,
            ori_px_trade_no: @bank_transaction_id,
            none_discount_amount: 0,
            none_feedback_amount: 0,
            amount: @amount,
            remark1: @remark1 || '',
            remark2: @remark2 || '',
            remark3: @remark3 || '',
            marketing: [],
            products: []
          )
        end

        def request_action
          'Refund'
        end

        def hash_string
          [@store_id, @pos_id, @trade_time, @bank_transaction_id, @refund_transaction_id, @amount, request_time].join
        end
      end
    end
  end
end
