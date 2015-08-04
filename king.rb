require_relative 'steepingpiece'

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
  end

  def moves
    DELTA.map{ |el| [el[0] + pos[0], el[1] + pos[1]] }.select{ |pos| Piece.on_board?(pos)}
      .select{ board[pos].nil? || board[pos].color != color }
  end

  def valid_moves #not in check

  end
end
