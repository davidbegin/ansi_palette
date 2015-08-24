# require "ansi_palette/version"

module AnsiPalette
  START_ESCAPE_SEQUENCE = "\e[" # "\033["
  END_ESCAPE_SEQUENCE = "m"
  RED_FG = "31"
  GREEN_FG = "32"

  # I do not know if this is 0 actual purpose
  RESET_COLOR = "0"

  class ColoredString
    def initialize(string, color)
      @string = string
      @color  = color
    end

    def green(substring)
      beginning, last = string.split(substring)
      "#{Red(beginning)}#{Green(substring)}#{Red(last)}"
    end

    def to_s; colored_string; end
    def to_str; colored_string; end

    def colored_string
      @colored_string ||= set_color + string + reset_color
    end

    def set_color
      escape_sequence(
        AnsiPalette.const_get(color.to_s.upcase + "_FG")
      )
    end

    private

    attr_reader :string, :color

    def reset_color
      escape_sequence(RESET_COLOR)
    end

    def escape_sequence(content)
      START_ESCAPE_SEQUENCE + content + END_ESCAPE_SEQUENCE
    end
  end
end

def Red(string)
  AnsiPalette::ColoredString.new(string, :red)
end

def Green(string)
  AnsiPalette::ColoredString.new(string, :green)
end
