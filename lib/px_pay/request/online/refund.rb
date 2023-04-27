# frozen_string_literal: true

require 'px_pay/request/online/base'
require 'px_pay/response/online/refund'
require 'time'

module PxPay
  module Request
    module Online
      class Refund < Base
        attr_writer :amount, :trade_time, :remark1, :remark2, :remark3, :px_trade_no

        def mer_trade_no=(mer_trade_no)
          @mer_trade_no = mer_trade_no.to_s
        end

        def refund_mer_trade_no=(refund_mer_trade_no)
          @refund_mer_trade_no = refund_mer_trade_no.to_s
        end

        private

        def to_hash
          super.merge(
            mer_trade_no: @mer_trade_no,
            px_trade_no: @px_trade_no,
            refund_mer_trade_no: @refund_mer_trade_no,
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
          [@mer_trade_no, @px_trade_no, @trade_time, @refund_mer_trade_no, @amount, request_time].join
        end
      end
    end
  end
end
