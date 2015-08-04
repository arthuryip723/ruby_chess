require_relative 'slidingpiece'

class Bishop < SlidingPiece
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def to_s
    'B'.colorize(color)
  end
end
