require 'colorize'
require_relative 'piece'
require_relative 'display'
require 'byebug'

class Board
  def initialize
    @board = Array.new(8){Array.new(8)}
    setup_board
  end

  def setup_board
    place_pieces(:rook, :black, [[0,0], [0,7]])
    place_pieces(:rook, :white, [[7,0], [7,7]])
    place_pieces(:knight, :black, [[0,1], [0,6]])
    place_pieces(:knight, :white, [[7,1], [7,6]])
    place_pieces(:bishop, :black, [[0,2], [0,5]])
    place_pieces(:bishop, :white, [[7,2], [7,5]])
    place_pieces(:queen, :black, [[0,3]])
    place_pieces(:queen, :white, [[7,3]])
    place_pieces(:king, :black, [[0,4]])
    place_pieces(:king, :white, [[7,4]])
    (0..7).each do |col|
      place_pieces(:pawn, :black, [[1,col]])
      place_pieces(:pawn, :white, [[6,col]])
    end
    (2..5).each do |row|
      (0..7).each do |col|
        place_pieces(:null, :null, [[row, col]]) #TODO only need one null piece
      end
    end
  end

  def place_pieces(name, color, positions)
    #debugger
    positions.each { |pos| self[pos] = Piece.new(name, color, pos) }
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @board[row][col] = value
  end

  def valid_move?(pos)
    pos[0] >= 0 && pos[0] < 8 && pos[1] >= 0 && pos[1] < 8
  end

  def move_piece(start_pos, end_pos)
    raise InvalidMoveError unless self[start_pos].is_a? Piece
    valid_moves = self[start_pos].valid_moves
    raise InvalidMoveError unless valid_moves.include? end_pos
    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
  end
  attr_accessor :board
end

class InvalidMoveError < StandardError
  def message
    "This is not a valid move"
  end
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new
  d = Display.new(b)
  #d.render

  d.move
  # b.render
  # b.move_piece([1,0], [3,0])
  # b.render
end