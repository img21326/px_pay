require 'jko_pay/response/online/base'

module JkoPay
  module Response
    module Online
      class Pay < Base
        attr_reader :payment_url

        def bank_transaction_id
          @transaction_id
        end

        def qr_img
          @qrcode
        end
      end
    end
  end
end
