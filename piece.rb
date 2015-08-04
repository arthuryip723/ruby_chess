require 'colorize'
# require_relative 'board'
class Piece

  attr_reader :color, :pos, :board

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

end
