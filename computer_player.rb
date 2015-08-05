

class ComputerPlayer

  attr_reader :name
  attr_accessor :color, :board
  def initialize(name)
    @name = name
  end



  def get_move(board)
    # first take highest value optimal move (safe move that takes piece)
    # then take any safe move if optimal moves is empty
    # then highest value of capturable moves if no safe moves
    # then any random move if no capturable moves

    escaping_moves = escaping_moves(board)
    safe_moves = safe_moves(board)
    capture_moves = capture_moves(board)
    best_capture_move = best_capture_move(board)
    optimal_moves = safe_moves & capture_moves

    if !escaping_moves.empty?
      # return escaping_moves.sample
      escaping_moves.each{ |move| return move if optimal_moves.include?(move)}
      return escaping_moves.sample
    end
    return highest_value_move(board, optimal_moves) if !optimal_moves.empty?
    return safe_moves.sample if !safe_moves.empty?
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

  def highest_value_move(board, moves)
    moves.sort_by{|move| board[move.last].value }.last
  end

  def safe_moves(board)
    result = []
    # temp_board = board.deep_dup
    # p all_possible_moves(temp_board)
    all_possible_moves(board).each do |move|
      # p move
      temp_board = board.deep_dup
      temp_board.move(move.first, move.last)
      # opponents_capturable_destinations
      # p board.opponent_moves(color)
      result << move if !temp_board.opponent_moves(color).include?(move.last)
    end
    result
  end

  # return the move a piece in danger can use
  def escaping_moves(board)
    # all_possible_moves(board).map{}
    # p pieces_in_danger(board)
    pieces_in_danger = pieces_in_danger(board)
    positions_of_pieces_in_danger = pieces_in_danger.map(&:pos)
    # p "Printing pieces in danger..."
    # p positions_of_pieces_in_danger
    safe_moves(board).select { |move| positions_of_pieces_in_danger.include?(move.first) }
  end

  def pieces_in_danger(board)
    board.own_pieces(color).select { |piece| board.opponent_moves(color).include?(piece.pos) }
    #position not in pair
  end

end
