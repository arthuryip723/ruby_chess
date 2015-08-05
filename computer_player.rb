

class ComputerPlayer

  attr_reader :name
  attr_accessor :color, :board
  def initialize(name)
    @name = name
  end



  def get_move(board)
    best_capture_move = best_capture_move(board)
    return best_capture_move if best_capture_move
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
    all_possible_moves(board).sample
  end

  def best_capture_move(board)
    capture_moves(board).sort_by{|move| board[move.last].value }.last
  end







end
