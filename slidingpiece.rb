require_relative 'piece'

class SlidingPiece < Piece
  def initialize
  end

  def moves
    DELTA.map{ |el| [el[0] + pos[0], el[1] + pos[1]] }.select{ |pos| Piece.on_board?(pos)}
      .select{ board[pos].nil? || board[pos].color != color }
  end
end
