require_relative 'slidingpiece'

class Queen < SlidingPiece
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def to_s
    "\u265B".colorize(color)
  end

  def value #Reinfeld value
    9
  end

  protected
  def move_dirs
    [[-1,0], [0,-1], [1,0], [0,1]] + [[-1,-1], [-1,1], [1,-1], [1,1]]
  end

end
