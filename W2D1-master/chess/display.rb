require 'colorize'
require_relative 'board'
require_relative 'cursor'


class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    board.board.each_with_index do |row, i| #TODO: change board instance variable name?
      print_row = ""
      row.each_with_index do |piece, j|
        if [i,j] == cursor.cursor_pos
          if piece.name == :null
            print_row << "  ".on_red
          else
            new_sqr = piece.name[0] + ' '
            print_row << new_sqr.colorize(piece.color).on_red
          end
        elsif (i + j) % 2 == 0
          if piece.name == :null
            print_row << "  ".on_cyan
          else
            new_sqr = piece.name[0] + ' '
            print_row << new_sqr.colorize(piece.color).on_cyan
          end
        else
          if piece.name == :null
            print_row << "  ".on_light_black
          else
            new_sqr = piece.name[0] + ' '
            print_row << new_sqr.colorize(piece.color).on_light_black
          end
        end
      end
      puts print_row
    end
  end

  def move
    while true
      render
      cursor.get_input
      system("clear")
    end
  end

  attr_reader :board, :cursor
end

