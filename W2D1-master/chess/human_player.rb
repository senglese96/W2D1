require_relative 'display'

class HumanPlayer
  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

  def make_move(board)

    first_pos = nil
    second_pos = nil
    while first_pos.nil?
      puts "It is currently #{color}'s turn"
      first_pos = display.cursor.get_input
      system "clear"
      display.render
    end

    while second_pos.nil?
      second_pos = display.cursor.get_input
      system "clear"
      display.render
    end

    system "clear"

    [first_pos, second_pos]

  end
end