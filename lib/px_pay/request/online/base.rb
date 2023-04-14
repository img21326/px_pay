# frozen_string_literal: true

require 'px_pay/request/base'

module PxPay
  module Request
    module Online
      class Base > PxPay::Request::Base
        private

        def api_host
          "#{config&.api_host}/px-ec"
        end
      end
    end
  end
end
