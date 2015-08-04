require_relative 'slidingpiece'

class Rook < SlidingPiece
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def to_s
    'R'.colorize(color)
  end
end
