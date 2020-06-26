# frozen_string_literal: true

require 'minitest/autorun'
load 'bowling_game.rb'

# bowling_game logic class
class BowlingGameTest < Minitest::Test
  def test_start
    bowling_game = BowlingGame.new

    assert_equal bowling_game.start.size, 10
    assert_equal bowling_game.start[1].class, Frame
    assert_equal bowling_game.start[1].turns, [2, 3]
  end

  def test_score
    bowling_game = BowlingGame.new
    bowling_game.start

    assert_equal bowling_game.score, 109
  end
end
