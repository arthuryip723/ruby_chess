require_relative 'piece'

class Pawn < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def to_s
    'P'.colorize(color)
  end
end
