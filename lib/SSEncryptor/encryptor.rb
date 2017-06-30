require 'openssl'

module SSEncryptor
  class Encryptor
    attr_reader :algorithm

    def initialize(key, options = {})
      @algorithm = options[:algorithm] || 'AES-256-CBC'
      @iv ||= options[:iv]
      process_and_set_key(key)
    end

    def process_and_set_key(key)
      key_len = OpenSSL::Cipher.new(@algorithm).key_len
      @key = key.rjust(key_len, key)[0..key_len - 1]
    end

    def encrypt(data)
      call(:encrypt, data)
    end

    def decrypt(data)
      call(:decrypt, data)
    end

    private

    def call(work, data)
      cipher = OpenSSL::Cipher.new(@algorithm)
      cipher.send(work)
      cipher.key = @key
      cipher.iv = @iv if @iv
      cipher.update(data) + cipher.final
    end
  end
end
