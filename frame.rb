# frozen_string_literal: true

require_relative 'base_frame.rb'

# frame logic class < BaseFrame
class Frame < BaseFrame
  def initialize
    @turns = []
  end

  def spare?
    @turns.sum == 10
  end

  def turns
    @turns
  end
end
