require 'colorize'
# require_relative 'board'
class Piece

  attr_reader :color
  attr_accessor :board, :pos

  def initialize(color, pos, board)
    @color, @pos, @board = color, pos, board
  end

  # def moves
  #
  # end


  def self.apply_step(pos, step)
    s1, s2 = step
    p1, p2 = pos
    [s1+p1, s2+p2]
  end

  def deep_dup(board)
    new_piece = self.dup
    new_piece.board = board
    # p "About to change pos"
    new_piece.pos = pos.dup
    new_piece
  end

  def move_into_check?(attempt)
    new_board = board.deep_dup
    new_board.move(pos, attempt)
    new_board.in_check?(color)
  end

  def valid_moves
    # p moves
    valids = moves.reject { |move| move_into_check?(move)}
    # p valids
    valids
  end

  def has_valid_moves?
    # p valid_moves
    valid_moves.length > 0
  end

end
