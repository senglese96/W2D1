require_relative 'piece'
require_relative 'stepable'

class King < Piece
  include Stepable
  attr_reader :symbol

  def initialize(color, position, board)
    @symbol = color == :white ? "\u2654" : "\u265A"
    super(color, position, board)
  end

  def move_dirs
    [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,-1], [-1,1]]
  end
  #TODO Check logic
end
