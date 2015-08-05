require_relative 'errors'

class HumanPlayer
  LETTER_MAP = {
    'a' => 0,
    'b' => 1,
    'c' => 2,
    'd' => 3,
    'e' => 4,
    'f' => 5,
    'g' => 6,
    'h' => 7
  }

  NUMBER_MAP = {
    '1' => 0,
    '2' => 1,
    '3' => 2,
    '4' => 3,
    '5' => 4,
    '6' => 5,
    '7' => 6,
    '8' => 7
  }

  attr_reader :name
  attr_accessor :color
  def initialize(name)
    @name = name
  end

  def get_move(board)
    start_pos, piece = get_valid_start_pos(board)
    end_pos = get_valid_end_pos(start_pos, piece)
    [start_pos, end_pos]
  end

  private
  def get_valid_start_pos(board)
    begin
      start_pos = get_start_pos
      piece = board[start_pos]
      raise NilPieceError if piece.nil?
      raise NoValidMovesError if !piece.has_valid_moves?
    rescue NilPieceError
      puts "That position is empty"
      retry
    rescue NoValidMovesError
      puts "No valid moves for this piece!"
      retry
    end
    [start_pos, piece]
  end

  def get_valid_end_pos(start_pos, piece)
    begin
      end_pos = get_end_pos
      raise NotValidMoveError if !piece.valid_moves.include?(end_pos)
    rescue NotValidMoveError
      puts "You can't move there."
      retry
    end
    end_pos
  end

  def get_start_pos
    ask_for_input('Enter the position of the piece you want to move, e.g. "f2"')
  end

  def get_end_pos
    ask_for_input('Enter the destination position, e.g. "f4"')
  end

  def ask_for_input(message)
    begin
      puts message.colorize(color)
      input = gets.chomp
      raise InputLengthError.new if input.length != 2
      input = input.split('')
      raise InputContentError.new if LETTER_MAP[input.first].nil? || NUMBER_MAP[input.last].nil?
    rescue InputLengthError
      puts "Invalid length!"
      retry
    rescue InputContentError
      puts "Invalid content!"
      retry
    end

    [ NUMBER_MAP[input.last], LETTER_MAP[input.first] ]
  end

end
