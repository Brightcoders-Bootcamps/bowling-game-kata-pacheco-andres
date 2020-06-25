# frozen_string_literal: true

require 'minitest/autorun'
require '../frame.rb'

# frame logic class test
class FrameTest < Minitest::Test
  def test_frame_completed_false
    frame = Frame.new

    assert_equal frame.turns_completed?, false
  end

  def test_frame_completed_true
    frame = Frame.new
    frame.add(3)
    frame.add(6)
    assert_equal frame.turns_completed?, true
  end

  def test_strike_false
    frame = Frame.new
    frame.add(2)
    assert_equal frame.strike?, false
  end

  def test_strike_true
    frame = Frame.new
    frame.add(10)
    assert_equal frame.strike?, true
  end

  def test_spare_false
    frame = Frame.new
    frame.add(5)
    frame.add(2)
    assert_equal frame.spare?, false
  end

  def test_spare_true
    frame = Frame.new
    frame.add(5)
    frame.add(5)
    assert_equal frame.spare?, true
  end

  def test_add
    frame = Frame.new
    frame.add(3)
    assert_equal frame.turns.include?(3), true
  end

  def test_turns
    frame = Frame.new
    frame.add(6)
    assert_equal frame.turns, [6]
  end
end
