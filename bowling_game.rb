# frozen_string_literal: true

require_relative 'frame.rb'
require_relative 'game_roll.rb'

# bowling game logic class
class BowlingGame
  def initialize
    @pins_down_collection = [10, 2, 3, 0, 0, 4, 6, 0, 0, 3, 4, 10, 10, 9, 3, 8, 1]
  end

  def start
    @frames = []
    game_roll = GameRoll.new
    pins_down_collection_iterator(game_roll)
    @frames
  end

  def pins_down_collection_iterator(game_roll)
    @pins_down_collection.each do |pins_down|
      game_roll.add(pins_down)
      frame = Frame.new

      if @frames.count == 10
        strike_or_spare(frame, pins_down)
      elsif game_roll.strike? && @frames.count <= 9
        frame.add(pins_down)
        @frames << frame
        game_roll.reset
      elsif game_roll.turns_completed? && @frames.count <= 9
        frame.add(game_roll.first_turn_pins_down)
        frame.add(game_roll.second_turn_pins_down)
        @frames << frame
        game_roll.reset
      end
    end
  end

  def strike_or_spare(frame, pins_down)
    if @frames.last.strike? || @frames.last.spare?
      frame.add(pins_down)
      @frames << frame
    end
  end

  def score
    score = 0
    bonus = 0
    
    @frames.each.with_index do |frame, index|
      score += frame.turns.sum
      
      if index == 9 && (frame.strike? || frame.spare?)
        bonus += @frames[index + 1].turns.first
      elsif frame.strike?
        if @frames[index + 1].strike?
          bonus += @frames[index + 1].turns.sum
          bonus += @frames[index + 2].turns.first
        else
          bonus += @frames[index + 1].turns.sum
        end
      elsif frame.spare?
        bonus += @frames[index + 1].turns.first
      end

      score += bonus
      bonus = 0
    end

    score
  end
end

 game = BowlingGame.new
 game.start.each do |frame|
   print frame.turns
 end
 puts "score #{game.score}"