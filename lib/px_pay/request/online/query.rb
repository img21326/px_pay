# frozen_string_literal: true

require 'px_pay/request/online/base'

module PxPay
  module Request
    module Online
      class Query < Base
        attr_writer :order_id

        private

        def to_hash
          {}
        end

        def request_action
          'Order'
        end

        def request_type
          :get
        end

        def hash_string
          ['Merchant', @order_id, @request_time].join
        end

        def end_point
          "#{super}/Merchant/#{@order_id}/#{request_time}"
        end
      end
    end
  end
end
