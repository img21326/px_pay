# frozen_string_literal: true

require 'cgi'
require 'faraday'
require 'digest'
require 'json'

module PxPay
  module Request
    class Base
      attr_accessor :config

      def initialize(params = nil)
        return unless params.is_a? Hash

        @config = nil
        params.each do |key, value|
          send "#{key}=", value
        end
        post_initialize
      end

      def request
        raise PxPay::Error, 'Missing Store ID' unless config&.store_id

        case request_type
        when :post
          res = send_post_request
        when :get
          res = send_get_request
        response_klass.new(res.body, raw: res)
      end

      private

      def post_initialize; end

      def to_hash; end

      def hash_string
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def request_type
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def request_action
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def response_klass
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def request_header
        {
          'Content-Type' => 'text/plain',
          'PX-MerCode' => config&.store_id,
          'PX-MerEnName' => config&.store_name || '',
          'PX-SignValue' => sign_value
        }
      end

      def send_post_request
        Faraday.post api_host, request_data, request_header
      end

      def send_get_request
        Faraday.get api_host, request_data, request_header
      end

      def request_data
        CGI.escape JSON.dump(to_hash)
      end

      def sign_value
        Digest::SHA2.hexdigest(hash_string)
      end

      def api_host
        config&.api_host
      end
    end
  end
end
