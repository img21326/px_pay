# frozen_string_literal: true

require 'px_pay/request/online/base'
require 'time'

module PxPay
  module Request
    module Online
      class Refund < Base
        attr_writer :order_id, :px_trade_no, :amount, :trade_time, :remark1, :remark2, :remark3

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
            refund_mer_trade_no: @order_id,
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
          [@order_id, @px_trade_no, @trade_time, @order_id, @amount, @request_time].join
        end
      end
    end
  end
end
