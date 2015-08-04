require_relative 'steppingpiece'

class Knight < SteppingPiece
  DELTA = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

  def initialize(color, pos, board)
    super(color, pos, board)
    @delta = Knight::DELTA
  end

  def to_s
    'N'.colorize(color)
  end

end
