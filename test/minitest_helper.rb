require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ansi_palette'
require 'minitest/autorun'
require "minitest/focus"
require "minitest/rg"
