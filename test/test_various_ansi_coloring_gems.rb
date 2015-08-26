require_relative "minitest_helper"

class TestVariousAnsiGems < Minitest::Test
  def test_colorize
    require "colorize"
    assert_equal "hello".red, "\e[0;31;49mhello\e[0m"
    assert_equal "hello".blink, "\e[5;39;49mhello\e[0m"
  end

  def test_pain
    require "paint"
    assert_equal Paint["hello", :red], "\033[31mhello\033[0m"
  end

  def test_term_ansicolor
    require 'term/ansicolor'
    self.class.include Term::ANSIColor
    assert_equal red("hello"), "\033[31mhello\033[0m"
  end

  def test_ansi_code
    require 'ansi/code'
    assert_equal ANSI.red {"hello"}, "\033[31mhello\033[0m"
    assert_equal ANSI.red + "hello", "\033[31mhello"
  end
end
