require_relative 'slidingpiece'

class Bishop < SlidingPiece
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def to_s
    "\u265D".colorize(color)
  end
  
  protected
  def move_dirs
    [[-1,-1], [-1,1], [1,-1], [1,1]]
  end

end
