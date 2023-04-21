# frozen_string_literal: true

require 'px_pay/request/online/base'
require 'px_pay/response/online/refund'
require 'time'

module PxPay
  module Request
    module Online
      class Refund < Base
        attr_writer :amount, :trade_time, :remark1, :remark2, :remark3, :px_trade_no

        def order_id=(order_id)
          @order_id = order_id.to_s
        end

        def refund_order_id=(refund_order_id)
          @refund_order_id = refund_order_id.to_s
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

        def to_hash
          super.merge(
            mer_trade_no: @order_id,
            px_trade_no: @px_trade_no,
            refund_mer_trade_no: @refund_order_id,
            amount: @amount,
            trade_time: @trade_time,
            remark1: @remark1 || '',
            remark2: @remark2 || '',
            remark3: @remark3 || ''
          )
        end

        def response_klass
          PxPay::Response::Online::Refund
        end

        def request_action
          'Refund'
        end

        def hash_string
          [@order_id, @px_trade_no, @trade_time, @refund_order_id, @amount, request_time].join
        end
      end
    end
  end
end
