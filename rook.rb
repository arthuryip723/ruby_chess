require_relative 'slidingpiece'

class Rook < SlidingPiece
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def to_s
    'R'.colorize(color)
  end

  def move_dirs
    [[-1,0], [0,-1], [1,0], [0,1]]
  end
end
