require 'singleton'
require 'byebug'

class Piece

  attr_reader :color, :board
  attr_accessor :position

  def initialize(color, position, board)
    @position = position
    @color = color
    @board = board
  end

  def valid_moves
    val_moves = []
    next_moves = self.moves
    next_moves.each do |move|
      hypo_board = board.dup
      hypo_board.move_piece!(color, position, move)
      val_moves << move unless hypo_board.in_check?(color)
    end
    val_moves
  end

end

class NullPiece < Piece
  include Singleton
  def initialize
  end
end

