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

---

Here is the new implementation I am working on, currently
still under heavy exploration.

```ruby
module AnsiPalette
  COLOR_HASH = {
    :black   => { :foreground => 30, :background => 40 },
    :red     => { :foreground => 31, :background => 41 },
    :green   => { :foreground => 32, :background => 42 },
    :yellow  => { :foreground => 33, :background => 43 },
    :blue    => { :foreground => 34, :background => 44 },
    :magenta => { :foreground => 35, :background => 45 },
    :cyan    => { :foreground => 36, :background => 46 },
    :white   => { :foreground => 37, :background => 47 },
  }

  COLOR_HASH.each_pair.each do |color, color_codes|
    define_method color.to_s.capitalize do |string|
      AnsiPalette::ColoredString.new(string, color)
    end

    const_set("#{color.upcase}_FG", color_codes.fetch(:foreground))
    const_set("#{color.upcase}_BG", color_codes.fetch(:background))
  end

  START_ESCAPE = "\e[" # "\033["
  END_ESCAPE   = "m"
  RESET_COLOR  = 0

  class ColoredString
    def initialize(string, color)
      @string = string
      @color  = color
    end

    def colored_string
      @colored_string ||= set_color + string + reset_color
    end

    def set_color
      escape_sequence(
        AnsiPalette.const_get(color.to_s.upcase + "_FG").to_s
      )
    end

    alias_method :to_s, :colored_string
    alias_method :to_str, :to_s

    private

    attr_reader :string, :color

    def reset_color
      escape_sequence(RESET_COLOR.to_s)
    end

    def escape_sequence(content)
      START_ESCAPE + content + END_ESCAPE
    end
  end
end

puts "\n\n"
puts %!puts Red("hello")!
puts Red("hello")
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
