# frozen_string_literal: true

require_relative 'base_frame.rb'

# game roll logic class
class GameRoll < BaseFrame
  attr_accessor :turns

  def initialize
    @turns = []
  end

  def first_turn_pins_down
    turns.first
  end

  def second_turn_pins_down
    turns.last
  end

  def reset
    self.turns = []
  end
end
