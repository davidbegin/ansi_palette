require_relative 'minitest_helper'

class TestAnsiPalette < Minitest::Test
  include AnsiPalette

  def test_that_it_has_a_version_number
    refute_nil ::AnsiPalette::VERSION
  end

  def test_coloring_a_string_red
    assert_equal Red("hello").to_s, "\033[31mhello\033[0m"
  end

  def test_add_coloring_a_string_cyan
    assert_equal Cyan("hello").to_str, "\033[36mhello\033[0m"
  end

  def test_add_background_color
    assert_equal BgCyan("hello").to_str, "\033[46mhello\033[0m"
  end

  def test_reset!
    colored_string = BgCyan("hello")
    colored_string.reset!
    assert_equal colored_string.to_str,"hello"
  end
end
