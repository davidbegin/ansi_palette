# AnsiPalette

This is a place to explore coloring Terminal output, and the various API's
for doing so. This will be comparing gems, as well as simple homegrown implementations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ansi_palette'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ansi_palette

First example is using Capitalized Conversion Methods,
which return instantances of ColoredString, which
act like strings when they need be

```ruby
def Red(string)
  colored_string = "\033[31m#{string}\033[0m"
  ColoredString.new(string, colored_string)
end

def Green(string)
  colored_string = "\033[32m#{string}\033[0m"
  ColoredString.new(string, colored_string)
end

class ColoredString
  def initialize(string, colored_string)
    @string = string
    @colored_string = colored_string
  end

  def green(substring)
    beginning, last = string.split(substring)
    "#{Red(beginning)}#{Green(substring)}#{Red(last)}"
  end

  def to_s; colored_string; end
  def to_str; colored_string; end

  private

  attr_reader :string, :colored_string
end

puts "\n\n"
puts %!puts Red("hello")!
puts Red("hello")

puts "\n\n"
puts %!Red("hello").green("e")!
puts Red("hello").green("e")

puts "\n\n"
puts %!Red("National SCRUM League").green("SCRUM")!
puts Red("National SCRUM League").green("SCRUM")
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ansi_palette/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
