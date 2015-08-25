require_relative 'minitest_helper'
require 'term/ansicolor'
require 'ansi/code'
require "paint"
require "colorize"

class TestAnsiPalette < Minitest::Test
  include Term::ANSIColor

  def test_that_it_has_a_version_number
    refute_nil ::AnsiPalette::VERSION
  end

  def test_coloring_a_string_red
    assert_equal Red("hello").to_str, "\033[31mhello\033[0m"
  end

  # Colorize seems to define all the defaults
  def test_add_colors_with_colorize
    assert_equal "hello".red, "\e[0;31;49mhello\e[0m"
  end

  def test_add_blink_with_colorize
    assert_equal "hello".blink, "\e[5;39;49mhello\e[0m"
  end

  def test_add_colors_with_paint
    assert_equal Paint["hello", :red], "\033[31mhello\033[0m"
  end

  def test_add_colors_with_ansi_color
    assert_equal red("hello"), "\033[31mhello\033[0m"
  end

  def test_add_color_with_ansi
    assert_equal ANSI.red {"hello"}, "\033[31mhello\033[0m"
    assert_equal ANSI.red + "hello", "\033[31mhello"
  end

  def test_add_color_with_custom_api
    assert_equal Cyan("hello").to_str, "\033[36mhello\033[0m"
  end
end
