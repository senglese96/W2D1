require 'byebug'

module Stepable
  def moves
    dirs = self.move_dirs
    all_moves = []
    dirs.each do |dir|
      new_pos = update(self.position, dir)
      if on_board?(new_pos) && board[new_pos].color != color
        all_moves << new_pos
      end
    end
    return all_moves
  end

  def update(pos, delta)
    r, c = pos
    rD, cD = delta
    [r + rD, c + cD]
  end

  def on_board?(pos)
    return false unless pos.all? { |spot| (0..7).to_a.include?(spot) }
    true
  end

  def unoccupied?(pos)
    return true if self.board.empty?(pos)
    false
  end
end