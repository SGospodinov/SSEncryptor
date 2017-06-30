require "spec_helper"
include SSEncryptor

RSpec.describe SSEncryptor do
  before(:each) do
    @key = 'Long and secret key'
    @message = 'Very sensitive data'
  end

  it 'ecnrypting and decrypting data correct' do
    en = Encryptor.new(@key)
    decr = en.encrypt(@message)
    expect(en.decrypt(decr)).to eq(@message)
  end

  it 'sets custom algorythm' do
    algorithm = 'AES-128-CBC'
    en = Encryptor.new(@key, algorithm: algorithm)
    expect(en.algorithm).to eq(algorithm)
  end

  it 'works with custom algorithm and iv' do
    iv = '1234567890123456'
    algorithm = 'AES-128-CBC'
    en = Encryptor.new(@key, algorithm: algorithm, iv: iv)
    decr = en.encrypt(@message)
    expect(en.decrypt(decr)).to eq(@message)
  end

  it 'works with different instances if the key is same' do
    en = Encryptor.new(@key)
    de = Encryptor.new(@key)
    decr = en.encrypt(@message)
    expect(de.decrypt(decr)).to eq(@message)
  end

  it 'work after setting new key' do
    en = Encryptor.new(@key)
    decr = en.encrypt(@message)
    expect(en.decrypt(decr)).to eq(@message)
    en.process_and_set_key('new key')
    decr = en.encrypt(@message)
    expect(en.decrypt(decr)).to eq(@message)
  end

  it 'decrypt multiple times' do
    en = Encryptor.new(@key)
    2.times do
      decr = en.encrypt(@message)
      expect(en.decrypt(decr)).to eq(@message)
    end
  end
end
