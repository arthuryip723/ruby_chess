class Piece

  attr_reader :color, :pos, :board

  def initialize(color, pos, board)
    @color, @pos, @board = color, pos, board
  end

  def moves

  end

  def self.on_board?(pos)
    pos.all?{ |coord| coord.between?(0,7) }
  end

  def self.select_on_board(positions)
    positions.select{ |pos| Piece.on_board?(pos)}
  end

  def not_occupied_by_self(positions)
    positions.select{ board[pos].nil? || board[pos].color != color }
  end

  def self.on_board_and_not_occupied(positions)
    Piece.select_on_board(positions)
  end


end
