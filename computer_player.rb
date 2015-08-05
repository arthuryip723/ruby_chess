

class ComputerPlayer
  
  attr_reader :name
  attr_accessor :color, :board
  def initialize(name)
    @name = name
  end

  # def get_start_pos
  # end
  #
  # def get_end_pos
  # end

  def get_move(board)
    # should return sth like [[1, 2], [3, 2]]
    capture_moves = capture_moves(board)
    return capture_moves.sample if !capture_moves.empty?
    random_move(board)
  end

  def all_possible_moves(board)
    possible_moves = []
    available_pieces = board.own_pieces(color).select!(&:has_valid_moves?)
    available_pieces.each do |piece|
      piece.valid_moves.each do |move|
        possible_moves << [piece.pos, move]
      end
    end
    possible_moves
  end

  def capture_moves(board)
    all_possible_moves(board).select do |move|
      cell = board[move.last]
      !cell.nil? && cell.color != color
    end
  end

  def random_move(board)
    # moves.sample
    all_possible_moves(board).sample
  end







end
