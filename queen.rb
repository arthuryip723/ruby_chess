require_relative 'slidingpiece'

class Queen < SlidingPiece
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def to_s
    'Q'.colorize(color)
  end
end
