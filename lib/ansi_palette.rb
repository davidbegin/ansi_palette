require "ansi_palette/version"

module AnsiPalette
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
end

def Red(string)
  colored_string = "\033[31m#{string}\033[0m"
  AnsiPalette::ColoredString.new(string, colored_string)
end

def Green(string)
  colored_string = "\033[32m#{string}\033[0m"
  AnsiPalette::ColoredString.new(string, colored_string)
end
