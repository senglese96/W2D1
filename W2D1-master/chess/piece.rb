require_relative 'board'

class Piece

  attr_reader :name, :color
  attr_accessor :position

  def initialize(name, color, position)
    @name = name
    @position = position
    @color = color
  end

  def valid_moves
    answer = []
    (0..7).each do |row|
      (0..7).each do |col|
        answer << [row, col]
      end
    end
    answer
  end

end

