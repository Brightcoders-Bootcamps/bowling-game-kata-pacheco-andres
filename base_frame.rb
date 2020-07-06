# frozen_string_literal: true

# BaseFrame class to inheritance methods
class BaseFrame
  attr_reader :turns

  def strike?
    turns.size == 1 && turns.sum == 10
  end

  def add(pin_down)
    turns << pin_down
  end

  def turns_completed?
    turns.size == 2
  end
end
