require_relative 'steppingpiece'

class King < SteppingPiece
  DELTA = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
  ]

  def initialize(color, pos, board)
    super(color, pos, board)
    @delta = DELTA
  end

 def to_s
   'K'.colorize(color)
 end
end
