require 'colorize'
# require_relative 'board'
class Piece

  attr_reader :color
  attr_accessor :board, :pos

  def initialize(color, pos, board)
    @color, @pos, @board = color, pos, board
  end

  def moves

  end


  def self.apply_step(pos, step)
    s1, s2 = step
    p1, p2 = pos
    [s1+p1, s2+p2]
  end

  def deep_dup(board)
    new_piece = self.dup
    new_piece.board = board
    new_piece.pos = pos.dup
    new_piece
  end

end
