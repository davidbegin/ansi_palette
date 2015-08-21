require_relative 'minitest_helper'

def Red(string)
  "\033[31m#{string}\033[0m"
end

class TestAnsiPalette < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::AnsiPalette::VERSION
  end

  # :red "\033[31m#{self}\033[0m"
  def test_coloring_a_string_red
    Red("hello")
    assert_equal Red("hello"), "\033[31mhello\033[0m"
  end
end
