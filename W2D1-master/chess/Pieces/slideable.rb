require_relative 'piece'

module Slideable
  def moves
    dirs = self.move_dirs
    all_moves = []
    dirs.each do |dir|
      new_pos = update(self.position, dir)
      while on_board?(new_pos) 
        if occupied?(new_pos)
          if board[new_pos].color != color
            all_moves << new_pos
          end
          break
        end
        all_moves << new_pos
        new_pos = update(new_pos, dir)
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

  def occupied?(pos)
    return false if self.board.empty?(pos)
    true
  end
end

