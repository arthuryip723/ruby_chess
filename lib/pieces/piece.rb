require 'colorize'
# require_relative 'board'
class Piece
  attr_reader :color
  attr_accessor :pos, :board

  def initialize(color, pos, board)
    @color, @pos, @board = color, pos, board
  end

  def deep_dup(board)
    new_piece = self.dup
    new_piece.board = board
    new_piece.pos = pos.dup
    new_piece
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move)}
  end

  def has_valid_moves?
    valid_moves.length > 0
  end

  private

  def move_into_check?(attempt)
    new_board = board.deep_dup
    new_board.move(pos, attempt)
    new_board.in_check?(color)
  end

  def self.apply_step(pos, step)
    s1, s2 = step
    p1, p2 = pos
    [s1+p1, s2+p2]
  end

end
