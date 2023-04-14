# frozen_string_literal: true

require 'px_pay/response/base'

module PxPay
  module Response
    module Online
      class Base < ::PxPay::Response::Base
        def status
          @status_code
        end

        def message
          @status_message
        end
      end
    end
  end
end
