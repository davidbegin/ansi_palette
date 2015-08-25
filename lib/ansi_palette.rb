require "ansi_palette/version"

module AnsiPalette
  START_ESCAPE_SEQUENCE = "\e[" # "\033["
  END_ESCAPE_SEQUENCE = "m"
  RED_FG     = 31
  GREEN_FG   = 32
  BLACK_FG   = 30
  RED_FG     = 31
  GREEN_FG   = 32
  YELLOW_FG  = 33
  BLUE_FG    = 34
  MAGENTA_FG = 35
  CYAN_FG    = 36
  WHITE_FG   = 37

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
        AnsiPalette.const_get(color.to_s.upcase + "_FG").to_s
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

[
  :cyan,
  :red,
  :green
].each do |color|
  define_method color.to_s.capitalize do |string|
    AnsiPalette::ColoredString.new(string, color)
  end
end
