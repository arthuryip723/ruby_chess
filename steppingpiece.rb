require_relative 'piece'

class SteppingPiece < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def moves
    # Piece.select_on_board(DELTA.map{ |el| [el[0] + pos[0], el[1] + pos[1]] })
    #   .select{ board[pos].nil? || board[pos].color != color }
    board.on_board_and_not_occupied(apply_delta_to_pos)
  end

  def apply_delta_to_pos
    DELTA.map{ |el| [el[0] + pos[0], el[1] + pos[1]] }
  end

end
