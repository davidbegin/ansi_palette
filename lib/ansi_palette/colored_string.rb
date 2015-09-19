require "forwardable"

module AnsiPalette
  START_ESCAPE     = "\e[".freeze
  ALT_START_ESCAPE = "\033[".freeze
  END_ESCAPE       = "m".freeze
  RESET_CODE       = "0".freeze

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
    :bold           => 1,
    :underline      => 4,
    :blink          => 5,
    :inverse_colors => 7
  }

  COLOR_HASH.each_pair.each do |color, color_codes|
    # defines the following methods:
    #   Black, Red, Green, Yellow, Blue, Magenta, Cyan, White
    #
    # which all return a ColoredString instance
    define_method color.to_s.capitalize do |string|
      AnsiPalette::ColoredString.new(string: string, color: color)
    end

    # defines the following methods:
    #   BlackBg, RedBg, GreenBg, YellowBg, BlueBg, MagentaBg, CyanBg, WhiteBg
    #
    # which all return a ColoredString instance
    define_method "Bg" + color.to_s.capitalize do |string|
      AnsiPalette::ColoredString.new(string: string, background_color: color)
    end

    # defines the following constants:
    #   BLACK_FG, RED_FG, GREEN_FG, YELLOW_FG,_BLUE_FG, MAGENTA_FG,
    #   CYAN_FG, WHITE_FG
    const_set("#{color.upcase}_FG", color_codes.fetch(:foreground))

    # defines the following constants:
    #   BLACK_BG, RED_BG, GREEN_BG, YELLOW_BG,_BLUE_BG, MAGENTA_BG,
    #   CYAN_BG, WHITE_BG
    const_set("#{color.upcase}_BG", color_codes.fetch(:background))
  end

  class ColoredString
    extend ::Forwardable

    # @param string [String] the string you would like to colorize
    # @param color [Symbol] the color you would like to affect on the string
    # @param background_color [Symbol] the color you would like to affect
    #   on the background of the string
    # @param modifier [Integer] the ANSI escape code for the modifier you
    #   would like to apply to the string passed in
    # @param options [Hash] for adding effects to your string
    #
    # @example Using options hash
    # ColoredString.new(string: "hello", color: :red, {:blink => true})
    def initialize(string:,
                   color: nil,
                   background_color: nil,
                   modifier: nil,
                   **options)

      @string           = string
      @color            = color
      @background_color = background_color
      @modifier         = modifier
      set_modifier_options(options)
    end

    attr_accessor :string,
      :color,
      :background_color,
      :modifier

    # Defines the following methods:
    #  #bold=, #underline=, #blink=, #inverse_colors=
    EFFECT_HASH.keys.each do |modifier_method|
      attr_accessor modifier_method
    end

    def to_s
      modified_string + reset_color
    end

    # removes all ansi escape codes from string
    def reset!
      @color = nil
      @background_color = nil

      EFFECT_HASH.each_pair do |modifier, _|
        instance_variable_set("@#{modifier}", nil)
      end
    end

    alias_method :to_str, :to_s
    def_delegators :string, :length

    private

    def modified_string
      set_modifiers +
        set_foreground_color +
        set_background_color +
        string
    end

    def set_modifiers
      set_modifier +
        set_blink +
        set_bold +
        set_blink +
        set_underline +
        set_inverse_colors
    end

    def set_modifier_options(options)
      EFFECT_HASH.keys.each do |modifier|
        instance_variable_set("@#{modifier.to_s}", options[modifier])
      end
    end

    EFFECT_HASH.each_pair do |modifier, code|
      # defines the following methods:
      #   #blink?, #bold?, #inverse_colors?, #underline?
      define_method "#{modifier}?" do
        instance_variable_get("@#{modifier}")
      end

      # defines the following methods:
      #   #set_blink, #set_bold, #set_inverse_colors, #set_underline,
      define_method "set_#{modifier}" do
        send("#{modifier}?") ? escape_sequence(code.to_s) : ""
      end
    end

    def set_modifier
      !modifier.nil? ? escape_sequence(modifier.to_s) : ""
    end

    def set_foreground_color
      set_color(color, "_FG")
    end

    def set_background_color
      set_color(background_color, "_BG")
    end

    def set_color(color, color_type)
      return "" if color.nil?

      escape_sequence(
        AnsiPalette.const_get(color.to_s.upcase + color_type).to_s
      )
    end

    def reset_color
      return "" if string == modified_string

      escape_sequence(RESET_CODE)
    end

    def escape_sequence(content)
      START_ESCAPE + content + END_ESCAPE
    end
  end
end
