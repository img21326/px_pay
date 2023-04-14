# frozen_string_literal: true

require 'px_pay/request/base'

module PxPay
  module Request
    module Online
      class Pay < Base
        enum_for :device_type, %i[pc mobile app]
        attr_writer :order_id, :amount, :device_type, :web_confirm_url, :web_cancel_url, :app_confirm_url,
                    :app_cancel_url

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

        def request_type
          :post
        end

        def hash_string
          [@order_id, @amount, @device_type, @request_time].join
        end
      end
    end
  end
end
