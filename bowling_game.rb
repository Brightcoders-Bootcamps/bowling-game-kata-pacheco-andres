# frozen_string_literal: true

require_relative 'frame.rb'
require_relative 'game_roll.rb'

# bowling game logic class
class BowlingGame
  attr_accessor :frames, :pins_down_collection

  def initialize
    @pins_down_collection = [10, 2, 3, 0, 0, 4, 6, 0, 0, 3, 4, 10, 10, 9, 3, 8, 1]
  end

  def start
    self.frames = []
    game_roll = GameRoll.new
    pins_down_collection_iterator(game_roll)
    frames
  end

  def pins_down_collection_iterator(game_roll)
    pins_down_collection.each do |pins_down|
      game_roll.add(pins_down)
      frame = Frame.new

      frame_type_validator(game_roll, pins_down, frame)
    end
  end

  def frame_type_validator(game_roll, pins_down, frame)
    if frames_count == 10
      strike_or_spare(frame, pins_down)
    elsif game_roll.strike? && frames_count <= 9
      frame.add(pins_down)
      frames << frame
      game_roll.reset
    elsif game_roll.turns_completed? && frames_count <= 9
      add_game_roll_to_frame(frame, game_roll)
    end
  end

  def frames_count
    frames.count
  end

  def add_game_roll_to_frame(frame, game_roll)
    frame.add(game_roll.first_turn_pins_down)
    frame.add(game_roll.second_turn_pins_down)
    frames << frame
    game_roll.reset
  end

  def strike_or_spare(frame, pins_down)
    return unless frames.last.strike? || frames.last.spare?

    frame.add(pins_down)
    frames << frame
  end

  def score
    total_score = 0
    bonus = 0

    frames.each.with_index do |frame, index|
      total_score += frame.turns.sum

      bonus = bonus_calculation(frame, index, bonus)
      total_score += bonus
      bonus = 0
    end

    total_score
  end

  def bonus_calculation(frame, index, bonus)
    if index == 9 && (frame.strike? || frame.spare?)
      bonus += frames_index_position(index).turns.first
    elsif frame.strike?
      bonus += strike_score(bonus, index)
    elsif frame.spare?
      bonus += frames_index_position(index).turns.first
    end

    bonus
  end

  def strike_score(bonus, index)
    if frames_index_position(index).strike?
      bonus += frames[index + 2].turns.first
    end

    bonus + frames_index_position(index).turns.sum
  end

  def frames_index_position(index)
    frames[index + 1]
  end
end

# game = BowlingGame.new
# game.start.each do |frame|
# print frame.turns
# end
# puts "score #{game.score}"
