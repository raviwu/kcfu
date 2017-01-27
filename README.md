# Kcfu

Kindle `My Clippings.txt` is a simple file that aggregate the clippings by clipping time, so the book clipping is mixed into a single file.

KCFU (Kindle Clipping File Util) simply helps to parse the `My Clippings.txt` file into separated txt file with `Book Title 1.txt`, `Book Title 2.txt` based on the clippings's book title information.

The core kindle format parsing job relies on the [kindleclippings](https://github.com/georgboe/kindleclippings) project.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kcfu'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kcfu

## Usage

### Separate the 'My Clippings.txt' to separated txt file according to the book title

`Kcfu::FileUtil#parse_file` will create a 'kindle_clippings' folder under PWD and separate the clippings by book_title in provided `My Clippings.txt` file.

adding `convert: :markdown` option will generate a simple markdown for the generated file

    require 'kcfu'

    parser = Kcfu::FileUtil.new
    parser.parse_file('My Clippings.txt', convert: :markdown)

### Simple Markdown parser to generate the clippings

`Kcfu::MdConvertor#parse_file` will create a corresponding `Book Clippings.md` according to provided `Book Clippings.txt` file.

    require 'kcfu'

    parser = Kcfu::MdConvertor.new
    parser.parse_file('Book Clippings.txt')

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/raviwu/kcfu. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

