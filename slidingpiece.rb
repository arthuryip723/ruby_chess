require_relative 'piece'

class SlidingPiece < Piece
  
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def moves
    result = []
    move_dirs.each do |dir|
      temp_pos = Piece.apply_step(pos, dir)
      while Board.on_board?(temp_pos) && board[temp_pos].nil?
        result << temp_pos
        temp_pos = Piece.apply_step(temp_pos, dir)
      end
      result << temp_pos if Board.on_board?(temp_pos) &&
        board[temp_pos].color != color  #add last move if opp is there
    end
    result
  end

end
