# frozen_string_literal: true

require_relative 'px_pay/version'
require_relative 'px_pay/request'
require_relative 'px_pay/response'
require_relative 'px_pay/config'

module PxPay
  class Error < StandardError; end
end
