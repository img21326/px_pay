require 'px_pay/response/pos/base'

module PxPay
  module Response
    module Pos
      class Reversal < Base
        def trade_time
          @trade_time = Time.parse(@px_trade_time) if @px_trade_time.instance_of? String
        end
      end
    end
  end
end
