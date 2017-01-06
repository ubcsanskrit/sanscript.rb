# Sanscript.rb

[![Gem Version](https://badge.fury.io/rb/sanscript.svg)](https://badge.fury.io/rb/sanscript)
[![Dependency Status](https://gemnasium.com/badges/github.com/ubcsanskrit/sanscript.rb.svg)](https://gemnasium.com/github.com/ubcsanskrit/sanscript.rb)
[![Build Status](https://travis-ci.org/ubcsanskrit/sanscript.rb.svg?branch=master)](https://travis-ci.org/ubcsanskrit/sanscript.rb)
[![Coverage Status](https://coveralls.io/repos/github/ubcsanskrit/sanscript.rb/badge.svg?branch=master)](https://coveralls.io/github/ubcsanskrit/sanscript.rb?branch=master)
[![Code Climate](https://codeclimate.com/github/ubcsanskrit/sanscript.rb/badges/gpa.svg)](https://codeclimate.com/github/ubcsanskrit/sanscript.rb)
[![Inline docs](http://inch-ci.org/github/ubcsanskrit/sanscript.rb.svg?branch=master)](http://inch-ci.org/github/ubcsanskrit/sanscript.rb)

This gem is starting off as a mostly-straightforward port of [learnsanskrit.org's Sanscript.js](https://github.com/sanskrit/sanscript.js), and will go from there. It also incorporates transliteration scheme detection based on [learnsanskrit.org's Detect.js](https://github.com/sanskrit/detect.js).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sanscript'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sanscript

## Usage

You can access detection through `Sanscript.detect(text)` and transliteration through `Sanscript.transliterate(text, from, to)`.

Documentation is provided in YARD format and available online at [rubydoc.info](http://www.rubydoc.info/github/ubcsanskrit/sanscript.rb).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ubcsanskrit/sanscript. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
