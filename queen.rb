require_relative 'slidingpiece'

class Queen < SlidingPiece
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def to_s
    'Q'.colorize(color)
  end

  def move_dirs
    [[-1,0], [0,-1], [1,0], [0,1]] + [[-1,-1], [-1,1], [1,-1], [1,1]]
  end
end
