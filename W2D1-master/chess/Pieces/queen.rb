require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
  include Slideable
  attr_reader :symbol

  def initialize(color, position, board)
    @symbol = color == :white ? "\u2655" : "\u265B"
    super(color, position, board)
  end

  def move_dirs
    [[1,0], [0,-1], [-1,0], [0,1], [1,1], [1,-1], [-1,-1], [-1,1]]
  end
end