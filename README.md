# SSEncryptor
[![Gem Version](https://badge.fury.io/rb/SSEncryptor.svg)](https://badge.fury.io/rb/SSEncryptor)
[![Build Status](https://travis-ci.org/SGospodinov/SSEncryptor.svg?branch=master)](https://travis-ci.org/SGospodinov/SSEncryptor)

SSEncryptor provides simplified interface for work with ruby openssl cipher. The process of encryption/decryption is symmetric.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'SSEncryptor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install SSEncryptor

## Usage
The basic usage is very simple. You just have to specify the key and the data which you want to cipher.
```ruby
key = 'Long and secret key'
message = 'Very sensitive data'

encryptor = SSEncryptor::Encryptor.new(key)
encrypted_data = encryptor.encrypt(message)
encryptor.decrypt(encrypted_data) #=> Very sensitive data
```
The key size will be processed according to the specific algorithm you are using. E.g. AES-128-CBC needs 16-byte key but we are passing it larger string so it will use the first 16 bytes(in this case `'Long and secret '`). If the key is shorter than needed (for example `'key'`) it will be right justified with itself. So the key used by cipher will be `'keykeykeykeykkey'`.

The default algorithm used by SSEncryptor is AES-256-CBC but you can specify it and the initialization vector(IV) by passing them as options in the constructor.
```ruby
key = 'Long and secret key'
iv = '1234567890123456'
algorithm = 'AES-128-CBC'

encryptor = SSEncryptor::Encryptor.new(key, algorithm: algorithm, iv: iv)
```
Be careful with IV because SSEncryptor does not ensure that its length is suitable for the given algorithm.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SGospodinov/SSEncryptor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SSEncryptor project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/SGospodinov/SSEncryptor/blob/master/CODE_OF_CONDUCT.md).
