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

header = Red("WOAH")
header.blink = true

puts "$$$$$$$$"
puts "$ #{header} $"
puts "$$$$$$$$"

class Billboard
  def initialize(text:, border: "†")
    @text   = text
    @border = border
  end

  def display
    puts "\n"
    puts border * length
    print border + " "
    print text
    puts " " + border
    print border * length
    puts "\n"
  end

  private

  attr_reader :text, :border

  def length
    text.length + 4
  end
end

billboad = Billboard.new(text: "DINOSAURS")
billboad.display

header = Cyan("PINOT NOIR")
header.blink = true
header.underline = true
header.bold = true
billboad = Billboard.new(text: header, border: "®")
billboad.display

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
