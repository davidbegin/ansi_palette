# AnsiPalette

[![Gem Version](https://badge.fury.io/rb/ansi_palette.svg)](http://badge.fury.io/rb/ansi_palette) [![Build Status](https://travis-ci.org/davidbegin/ansi_palette.svg?branch=master)](https://travis-ci.org/davidbegin/ansi_palette) [![Test Coverage](https://codeclimate.com/github/presidentJFK/ansi_palette/badges/coverage.svg)](https://codeclimate.com/github/presidentJFK/ansi_palette/coverage) [![Code Climate](https://codeclimate.com/github/presidentJFK/ansi_palette/badges/gpa.svg)](https://codeclimate.com/github/presidentJFK/ansi_palette) [![Dependency Status](https://gemnasium.com/presidentJFK/ansi_palette.svg)](https://gemnasium.com/presidentJFK/ansi_palette) [![Inline docs](http://inch-ci.org/github/davidbegin/ansi_palette.svg?branch=master)](http://inch-ci.org/github/davidbegin/ansi_palette)

AnsiPalette is yet another terminal coloring gem.
I have never been satisfied with the various coloring gems,
for one reason or another, and never knew the details of how each worked.

Goals of this Gem:
  * Help me understand more about ANSI escape characters
  * Create code the makes it easy to understand how ANSI escape charactors are used
  * Create a simple and usable API for coloring strings

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

```ruby
include AnsiPalette

puts Red("hello")

header = <<-HEADER
  A Classy Comment Header
HEADER

body = <<-BODY
  Some very interesting comment text.
  With all these intricate details.
  Explaining everything you could ever
  want to know.
BODY

doc = <<-DOC
  #{Red(header)}
    #{Cyan(body)}
DOC

puts doc

color = Blue("Header")
puts color

color = Red("Header")
color.bold = true
puts color

color = Yellow("Header")
color.bold = true
color.blink = true
puts color

color = Yellow("Header")
color.bold = true
color.blink = true
color.modifier = 3
puts color

color = Cyan("Header")
color.bold = true
color.modifier = 4
puts color

color = Red("Header")
color.inverse_colors = true
color.bold
puts color

# You can also you use the ColoredString class
colored_string = AnsiPalette::ColoredString.new(string: "hello")
colored_string.color = :red
puts colored_string
colored_string.background_color = :yellow
puts colored_string
colored_string.bold = true
puts colored_string
colored_string.blink = true
puts colored_string
colored_string.underline = true
puts colored_string
colored_string.inverse_colors = true
puts colored_string
colored_string.reset!
puts colored_string
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ansi_palette/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
