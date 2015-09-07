require_relative "../lib/ansi_palette"

include AnsiPalette

puts "\n\n"
puts %!puts Red("hello")!
puts Red("hello")
puts "\n\n"

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
