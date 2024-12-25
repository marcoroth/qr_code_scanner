# QRCodeScanner

A Ruby Gem for scanning QR codes from documents like PDFs and images.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add qr_code_scanner
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install qr_code_scanner
```

Install the required NPM packages:

```bash
yarn add @andreekeberg/imagedata pdf-to-png-converter jsqr
```

#### Note

This gem is built on top of the [`jsQR`](https://github.com/cozmo/jsQR) NPM package, which means you need to be running [Node.js](https://nodejs.org/en). We utilize the [`nodo`](https://github.com/mtgrosser/nodo) gem for calling out to Node.js.

TL;DR: as long as you have Node.js installed and the above listed NPM packages installed you shouldn't notice that it's calling out to Node.js.


## Usage

Given the following QR Code:

![](https://github.com/marcoroth/qr_code_scanner/blob/main/test/fixtures/hello_world.png)

You can read out it's information using:

```ruby
require "qr_code_scanner"

QRCodeScanner.scan("path/to/qr_code.png")
# => ["hello world"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcoroth/qr_code_scanner. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/marcoroth/qr_code_scanner/blob/main/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the QRCodeScanner project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/marcoroth/qr_code_scanner/blob/main/CODE_OF_CONDUCT.md).
