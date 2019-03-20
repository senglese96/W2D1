require_relative 'board'
require_relative 'human_player'
require 'byebug'

class Game
  attr_reader :display, :player1, :player2, :players
  attr_accessor :board, :current_player

  def initialize
    @board = Board.new
    @display = Display.new(board)
    @player1 = HumanPlayer.new(:white, @display)
    @player2 = HumanPlayer.new(:black, @display)
    @current_player = :white
    p @current_player
    @players = {:white => player1, :black => player2}
  end

  def play
    begin
      while !board.checkmate?(@current_player)
        #puts "It is currently #{@current_player}'s turn"
        puts "Check!" if board.in_check?(current_player)
        display.render
        move = players[@current_player].make_move(board)
        board.move_piece(@current_player, move[0], move[1])
        @current_player = @current_player == :white ? :black : :white
      end
    rescue InvalidMoveError => e
      puts e.message
      retry
    ensure
      system "clear"
    end
    
    winning_player = @current_player == :white ? :black : :white
    system 'clear'
    display.render
    puts "Congratulations #{winning_player}, You Win!"
  end

  def swap_turn!
    
    if @current_player == :white
      :black
    else
      :white
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end