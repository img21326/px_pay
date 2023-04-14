module PxPay
  class Config
    PRODUCTION_HOST = ''.freeze
    SANDBOX_HOST = 'https://uat.pxpayplus.com/'.freeze

    attr_accessor :mode, :secret_key, :store_id

    def initialize
      @mode = :sandbox
      @store_id = nil
      @secret_key = nil
    end

    def production?
      @mode != :sandbox
    end

    def api_host
      return PRODUCTION_HOST if production?

      SANDBOX_HOST
    end
  end
end
