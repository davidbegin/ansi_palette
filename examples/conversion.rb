require_relative "../lib/ansi_palette"

puts "\n\n"
puts %!puts Red("hello")!
puts Red("hello")

puts "\n\n"
puts %!Red("hello").green("e")!
puts Red("hello").green("e")

puts "\n\n"
puts %!Red("National SCRUM League").green("SCRUM")!
puts Red("National SCRUM League").green("SCRUM")
