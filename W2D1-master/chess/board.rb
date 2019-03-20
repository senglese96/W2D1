require 'colorize'
Dir["/Users/appacademy/Desktop/W2D1/chess/Pieces/*.rb"].each {|file| require file}
require_relative 'display'
require 'byebug'


class Board

  attr_accessor :board

  def initialize
    @board = Array.new(8){Array.new(8)}
    setup_board
  end

  def setup_board

    [[0,0], [0,7]].each { |pos| self[pos] = Rook.new(:black, pos, self) }
    [[7,0], [7,7]].each { |pos| self[pos] = Rook.new(:white, pos, self) }
    [[0,1], [0,6]].each { |pos| self[pos] = Knight.new(:black, pos, self) }
    [[7,1], [7,6]].each { |pos| self[pos] = Knight.new(:white, pos, self) }    
    [[0,2], [0,5]].each { |pos| self[pos] = Bishop.new(:black, pos, self) }
    [[7,2], [7,5]].each { |pos| self[pos] = Bishop.new(:white, pos, self) }
    [[0,3]].each { |pos| self[pos] = Queen.new(:black, pos, self) }
    [[7,3]].each { |pos| self[pos] = Queen.new(:white, pos, self) }
    [[0,4]].each { |pos| self[pos] = King.new(:black, pos, self) }
    [[7,4]].each { |pos| self[pos] = King.new(:white, pos, self) }

    (0..7).each do |col|
      self[[1,col]] = Pawn.new(:black, [1,col], self)
      self[[6,col]] = Pawn.new(:white, [6,col], self)
    end
    (2..5).each do |row|
      (0..7).each do |col|
        self[[row, col]] = NullPiece.instance
      end
    end

    # self[[2,1]] = Pawn.new(:white, [2,0], self)
    # #self[[5,3]] = Knight.new(:black, [5,3], self)
    # #self[[6,4]] = Bishop.new(:white, [6,4], self)
    # self[[5,4]] = Rook.new(:black, [5,4], self)
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

  def empty?(pos)
    return true if self[pos].is_a? NullPiece
  end

  # def move_piece(start_pos, end_pos)
  #   raise InvalidMoveError unless self[start_pos].is_a? Piece
  #   valid_moves = self[start_pos].valid_moves
  #   raise InvalidMoveError unless valid_moves.include? end_pos
  #   self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
  # end

  def each(&prc)
    board.each do |row|
      row.each do |piece|
        prc.call(piece)
      end
    end
  end

  def find_king(color)
    self.each do |piece|
      return piece if piece.color == color && piece.is_a?(King)
    end
  end

  def in_check?(color)
    king = find_king(color)
    self.each do |piece|
      return true if !(piece.is_a?(NullPiece)) && piece.moves.include?(king.position)
    end
    return false
  end

  def checkmate?(color)
    self.each do |piece|
      return false if !(piece.is_a?(NullPiece)) && !piece.valid_moves.empty? && piece.color == color
    end
    true
  end

  def dup
    dupboard = Board.new
    (0..7).each do |row|
      (0..7).each do |col|
        piece = self[[row, col]]
        if piece.is_a? NullPiece
          dupboard[[row, col]] = NullPiece.instance
        else
          piece_type = piece.class
          dupboard[piece.position] = piece_type.new(piece.color, piece.position, dupboard)
        end
      end
    end
    dupboard
  end

  def move_piece!(color, start_pos, end_pos)
    self[start_pos].position = end_pos
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
  end

  def move_piece(color, start_pos, end_pos)
    if !self[start_pos].is_a?(NullPiece) && self[start_pos].valid_moves.include?(end_pos) && self[start_pos].color == color
      self[start_pos].position = end_pos
      self[end_pos] = self[start_pos]
      self[start_pos] = NullPiece.instance
    else
      raise InvalidMoveError
    end
  end
end


class InvalidMoveError < StandardError
  def message
    "This is not a valid move"
  end
end

if __FILE__ == $PROGRAM_NAME
  
  board = Board.new
  display = Display.new(board)

  p board.checkmate?(:white)
 
  display.render

end