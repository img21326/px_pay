# frozen_string_literal: true

require 'cgi'
require 'faraday'
require 'digest'
require 'json'
require 'px_pay/utils'

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
        raise PxPay::Error, 'Missing Store Name' unless config&.store_name

        begin
          res = send_request
          res_json_body = JSON.parse(res.body)
        rescue Faraday::ConnectionFailed, Faraday::TimeoutError
          res_json_body = {}
          res = nil
        end

        response_klass.new(res_json_body, res)
      end

      private

      def post_initialize; end

      def request_type
        :post
      end

      def hash_string
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
          'Content-Type' => 'application/json;charset=utf-8;',
          'PX-MerCode' => config&.store_id,
          'PX-MerEnName' => config&.store_name,
          'PX-SignValue' => sign_value
        }
      end

      def request_time
        @request_time ||= Time.now.strftime('%Y%m%d%I%M%S')
      end

      def to_hash
        {
          req_time: request_time
        }
      end

      def conn
        @conn ||= Faraday.new do |faraday|
          faraday.options.timeout = 15
        end
      end

      def send_request
        conn.send request_type, end_point, request_data, request_header
      end

      def request_data
        JSON.dump(to_hash)
      end

      def sign_value
        PxPay::Utils.sign hash_string, config&.secret_key
      end

      def api_host
        config&.api_host
      end

      def end_point
        "#{api_host}/#{request_action}"
      end
    end
  end
end
