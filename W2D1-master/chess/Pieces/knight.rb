require_relative 'piece'
require_relative 'stepable'

class Knight < Piece
  include Stepable
  attr_reader :symbol

  def initialize(color, position, board)
    @symbol = color == :white ? "\u2658" : "\u265E"
    super(color, position, board)
  end

  def move_dirs
    [[1,2], [2,-1], [-1,2], [2,1], [-2,1], [-2,-1], [-1,-2], [1,-2]]
  end
end