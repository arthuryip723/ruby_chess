require_relative 'piece'

class SteppingPiece < Piece
  attr_reader :delta
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def moves
    board.on_board_and_not_occupied(apply_delta_to_pos, color)
  end

  def apply_delta_to_pos
    delta.map{ |el| Piece.apply_step(pos, el) }
  end

end
