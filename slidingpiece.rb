require_relative 'piece'

class SlidingPiece < Piece
  H_AND_V = [[-1,0], [0,-1], [1,0], [0,1]]
  DIAGONAL = [[-1,-1], [-1,1], [1,-1], [1,1]]
  def initialize(color, pos, board)
    super(color, pos, board)
  end

  def moves
    result = []
    move_dirs.each do |dir|
      # temp_pos = [pos[0] + dir[0], pos[1] + dir[1]]
      temp_pos = Piece.apply_step(pos, dir)
      while Board.on_board?(temp_pos) && board[temp_pos].nil?
        result << temp_pos
        # temp_pos = [temp_pos[0] + dir[0], temp_pos[1] + dir[1]]
        temp_pos = Piece.apply_step(temp_pos, dir)
      end
      result << temp_pos if Board.on_board?(temp_pos) &&
        board[temp_pos].color != color  #add last move if opp is there
    end
    result
  end



end
