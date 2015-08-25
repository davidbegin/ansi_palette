require "ansi_palette/version"

module AnsiPalette
  COLOR_HASH = {
    :black       => 30,
    :red         => 31,
    :green       => 32,
    :yellow      => 33,
    :blue        => 34,
    :magenta     => 35,
    :cyan        => 36,
    :white       => 37
  }

  COLOR_HASH.each_pair.each do |color, color_code|
    define_method color.to_s.capitalize do |string|
      AnsiPalette::ColoredString.new(string, color)
    end

    const_set("#{color.upcase}_FG", color_code)
  end

  START_ESCAPE = "\e[" # "\033["
  END_ESCAPE   = "m"
  RESET_COLOR  = 0

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
      escape_sequence(RESET_COLOR.to_s)
    end

    def escape_sequence(content)
      START_ESCAPE + content + END_ESCAPE
    end
  end
end

