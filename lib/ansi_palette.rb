require "ansi_palette/version"

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

    define_method "Bg" + color.to_s.capitalize do |string|
      AnsiPalette::ColoredString.new(string, color, :background)
    end

    const_set("#{color.upcase}_FG", color_codes.fetch(:foreground))
    const_set("#{color.upcase}_BG", color_codes.fetch(:background))
  end

  def Bold(str)
    ColoredString.new(str, :bold).bold
  end

  START_ESCAPE = "\e[" # "\033["
  END_ESCAPE   = "m"
  RESET_COLOR  = 0

  class ColoredString
    def initialize(string, color, type = :foreground)
      @string = string
      @color  = color
      @type   = type
    end

    def bold
      escape_sequence("1") + string + reset_color
    end

    def colored_string
      @colored_string ||= set_color + string + reset_color
    end

    def set_color
      escape_sequence(
        AnsiPalette.const_get(color.to_s.upcase + color_type).to_s
      )
    end

    alias_method :to_s, :colored_string
    alias_method :to_str, :to_s

    private

    attr_reader :string, :color, :type

    def color_type
      case type
      when :background then "_BG"
      when :foreground then "_FG"
      end
    end

    def reset_color
      escape_sequence(RESET_COLOR.to_s)
    end

    def escape_sequence(content)
      START_ESCAPE + content + END_ESCAPE
    end
  end
end
