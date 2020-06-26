# frozen_string_literal: true

require 'minitest/autorun'
require '../game_roll.rb'

# game roll logic class
class GameRollTest < Minitest::Test
  def test_strike_false
    game_roll = GameRoll.new
    game_roll.add(3)

    assert_equal game_roll.strike?, false
  end

  def test_strike_true
    game_roll = GameRoll.new
    game_roll.add(10)

    assert_equal game_roll.strike?, true
  end

  def test_complited_false
    game_roll = GameRoll.new
    game_roll.add(1)

    assert_equal game_roll.completed?, false
  end

  def test_complited_true
    game_roll = GameRoll.new
    game_roll.add(1)
    game_roll.add(2)

    assert_equal game_roll.completed?, true
  end

  def test_add
    game_roll = GameRoll.new

    assert game_roll.add(1)
  end

  def test_first_pins_down
    game_roll = GameRoll.new
    game_roll.add(3)
    game_roll.add(4)

    assert_equal game_roll.first_turn_pins_down, 3
  end

  def test_second_pins_down
    game_roll = GameRoll.new
    game_roll.add(4)
    game_roll.add(6)

    assert_equal game_roll.second_turn_pins_down, 6
  end

  def test_reset
    game_roll = GameRoll.new

    assert game_roll.reset, true
  end
end
