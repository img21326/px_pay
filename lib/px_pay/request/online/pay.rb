# frozen_string_literal: true

require 'px_pay/request/online/base'
require 'px_pay/response/online/pay'

module PxPay
  module Request
    module Online
      class Pay < Base
        attr_writer :amount, :web_confirm_url, :web_cancel_url, :app_confirm_url,
                    :app_cancel_url

        def order_id=(order_id)
          @order_id = order_id.to_s
        end

        def device_type=(device_type)
          @device_type = {
            pc: 1,
            mobile: 2,
            app: 3
          }[device_type]
          raise ArgumentError, 'device_type must be :pc, :mobile or :app' unless @device_type
        end

        private

        def to_hash
          super.merge(
            mer_trade_no: @order_id,
            amount: @amount,
            device_type: @device_type,
            web_confirm_url: @web_confirm_url || '',
            web_cancel_url: @web_cancel_url || '',
            app_confirm_url: @app_confirm_url || '',
            app_cancel_url: @app_cancel_url || ''
          )
        end

        def request_action
          'CreateOrder'
        end

        def response_klass
          PxPay::Response::Online::Pay
        end

        def request_type
          :post
        end

        def hash_string
          [@order_id, @amount, @device_type, request_time].join
        end
      end
    end
  end
end
