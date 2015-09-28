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
   "\u265A".colorize(color)
  end

  def value #Reinfeld value
    10 #any valid value, we will never actually take king
  end

end
