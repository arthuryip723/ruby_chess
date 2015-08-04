require_relative 'slidingpiece'

class Rook < SlidingPiece
  MOVES_DIAGONALLY = false
  MOVES_HORZ_AND_VERT = true
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def to_s
    'R'.colorize(color)
  end
end
