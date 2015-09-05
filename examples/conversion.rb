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

puts Bold("Header")
