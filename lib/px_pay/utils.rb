module PxPay
  class Utils
    def self.sign(plaintext, secret_key)
      plaintext_bytes = plaintext.encode('utf-8')
      secret_key_bytes = [secret_key].pack('H*')

      hash = OpenSSL::HMAC.digest('sha256', secret_key_bytes, plaintext_bytes)
      hash.unpack1('H*')
    end
  end
end
