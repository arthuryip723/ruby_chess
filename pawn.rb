require_relative 'piece'

class Pawn < Piece
  def initialize(color, pos, board)
    super(color, pos, board)
    @initial_pos = true
  end

  def moves
    # [[1,0], [1,1], [1,-1]]
    dir = (color == Game::COLORS[0] ? -1 : 1)
    result = []
    [[dir,1], [dir,-1]].each do |step|
      new_pos = Piece.apply_step(pos, step)
      result << new_pos if Board.on_board?(new_pos) &&
                               !board[new_pos].nil? &&
                               board[new_pos].color != color
    end

    straight_steps = [[dir, 0]]
    straight_steps << [2*dir, 0] if initial_pos #Can move 2 steps forward on first step

    straight_steps.each do |step|
      new_pos = Piece.apply_step(pos, step)
      result << new_pos if Board.on_board?(new_pos) && board[new_pos].nil?
    end

    result

  end

  def pos=(value)
    # p "Changing position"
    # p value
    @pos = value
    @initial_pos = false
  end

  def to_s
    'P'.colorize(color)
  end

  private
  attr_reader :initial_pos
end

if __FILE__ == $PROGRAM_NAME
   b = Board.new
   pawn = b[1,0] #should be  a pawn there
   puts pawn.moves

end
