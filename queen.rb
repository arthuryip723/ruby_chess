require_relative 'slidingpiece'

class Queen < SlidingPiece
  MOVES_DIAGONALLY = true
  MOVES_HORZ_AND_VERT = true
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def to_s
    'Q'.colorize(color)
  end
end
