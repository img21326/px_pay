# frozen_string_literal: true

require 'cgi'
require 'digest'

module PxPay
  module Response
    class Base
      attr_reader :raw, :status_code

      def initialize(params, raw)
        @raw = raw
        params.each_pair do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def http_status_code
        @raw.status
      end

      def message
        @status_message
      end

      def success?
        status_code == '0000'
      end
    end
  end
end
