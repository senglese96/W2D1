require_relative 'piece'
require 'byebug'

class Pawn < Piece
  attr_reader :symbol

  def initialize(color, position, board)
    @symbol = color == :white ? "\u2659" : "\u265F"
    super(color, position, board)
  end

  def moves
    forward_steps + side_attacks
  end

  private
  def at_start_row?
    if color == :white && position[0] == 6
      true
    elsif color == :black && position[0] == 1
      true
    else
      false
    end
  end

  def forward_dir
    if color == :black
      [1,0]
    else
      [-1,0]
    end
  end

  def forward_steps
    moves = []
    new_pos = update(position, forward_dir)
    if board[new_pos].is_a?(NullPiece) && board.valid_move?(new_pos)
      if at_start_row?
        next_pos = update(new_pos, forward_dir)
        if board[next_pos].is_a? NullPiece
          moves << next_pos
        end
      end
      moves << new_pos
    end
    moves
  end

  def update(pos, delta)
    r, c = pos
    rD, cD = delta
    [r + rD, c + cD]
  end

  def side_attacks
    moves = []
    dir = update(position, forward_dir)
    moves << update(dir, [0, 1])
    moves << update(dir, [0, -1])
    moves = moves.select do |move|
      board.valid_move?(move) && board[move].color != color && !(board[move].is_a?(NullPiece))
    end
    moves
  end
  
end