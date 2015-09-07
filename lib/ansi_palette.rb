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

  EFFECT_HASH = {
    :reset          => 0,
    :bold           => 1,
    :underline      => 4,
    :blink          => 5,
    :inverse_colors => 7
  }

  COLOR_HASH.each_pair.each do |color, color_codes|
    define_method color.to_s.capitalize do |string|
      AnsiPalette::ColoredString.new(string: string, color: color)
    end

    define_method "Bg" + color.to_s.capitalize do |string|
      AnsiPalette::ColoredString.new(string: string, background: color)
    end

    const_set("#{color.upcase}_FG", color_codes.fetch(:foreground))
    const_set("#{color.upcase}_BG", color_codes.fetch(:background))
  end

  def Bold(str)
    ColoredString.new(string: str, bold: true).bold
  end

  START_ESCAPE = "\e[" # "\033["
  END_ESCAPE   = "m"
  RESET_COLOR  = 0

  class ColoredString
    def initialize(string:,
                   color: nil,
                   foreground: nil,
                   background: nil,
                   modifier: nil,
                   bold: false,
                   blink: false
                  )

      @string     = string
      @color      = color
      @modifier   = modifier
      @background = background
      @foreground = foreground
      @bold       = bold
      @blink      = blink
    end

    EFFECT_HASH.keys.each do |modifier_method|
      attr_accessor modifier_method
    end

    attr_accessor :modifier

    def colored_string
      set_modifiers +
        set_foreground_color +
        set_background_color +
        string +
        reset_color
    end

    def blink?; blink; end

    def bold?; bold; end

    alias_method :to_s, :colored_string
    alias_method :to_str, :to_s

    private

    attr_reader :string, :color, :modifier, :background, :foreground

    def set_modifiers
      set_modifier +
        set_blink +
        set_bold +
        set_underline +
        set_blink +
        set_inverse_colors
    end

    EFFECT_HASH.each_pair do |modifier, code|
      define_method "#{modifier}?" do
        instance_variable_get("@#{modifier}")
      end

      define_method "set_#{modifier}" do
        send("#{modifier}?") ? escape_sequence(code.to_s) : ""
      end
    end

    def set_modifier
      !modifier.nil? ? escape_sequence(modifier.to_s) : ""
    end

    def set_foreground_color
      set_color(foreground_color, "_FG")
    end

    def set_background_color
      set_color(background, "_BG")
    end

    def set_color(color, color_type)
      return "" if color.nil?

      escape_sequence(
        AnsiPalette.const_get(color.to_s.upcase + color_type).to_s
      )
    end

    def foreground_color
      color || foreground
    end

    def reset_color
      escape_sequence(RESET_COLOR.to_s)
    end

    def escape_sequence(content)
      START_ESCAPE + content + END_ESCAPE
    end
  end
end
