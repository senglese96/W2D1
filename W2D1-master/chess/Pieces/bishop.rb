require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
  include Slideable
  attr_reader :symbol

  def initialize(color, position, board)
    @symbol = color == :white ? "\u2657" : "\u265D"
    super(color, position, board)
  end

  def move_dirs
    [[1,1], [1,-1], [-1,-1], [-1,1]]
  end
end