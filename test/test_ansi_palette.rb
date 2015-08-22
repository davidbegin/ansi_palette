require_relative 'minitest_helper'
require 'term/ansicolor'

def Red(string)
  "\033[31m#{string}\033[0m"
end

class TestAnsiPalette < Minitest::Test
  include Term::ANSIColor

  def test_that_it_has_a_version_number
    refute_nil ::AnsiPalette::VERSION
  end

  def test_coloring_a_string_red
    assert_equal Red("hello"), "\033[31mhello\033[0m"
  end

  def test_add_colors_with_colorize
    require "colorize"
    assert_equal "hello".red, "\e[0;31;49mhello\e[0m"
  end

  def test_add_colors_with_paint
    require "paint"
    assert_equal Paint["hello", :red], "\033[31mhello\033[0m"
  end

  def test_add_colors_with_ansi_color
    assert_equal red("hello"), "\033[31mhello\033[0m"
  end

  def test_add_color_with_ansi
    require 'ansi/code'
    assert_equal ANSI.red {"hello"}, "\033[31mhello\033[0m"
    assert_equal ANSI.red + "hello", "\033[31mhello"
  end
end

