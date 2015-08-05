require_relative 'board'

class Game
  COLORS = [:blue, :red]

  attr_reader :board, :player1, :player2
  attr_accessor :current_player
  def initialize(player1, player2)
    # @current_player = color1
    # @color1 = color1
    # @color2 = color2
    @player1, @player2 = player1, player2
    player1.color = COLORS[0]
    player2.color = COLORS[1]
    @current_player = player2
    @board = Board.new
  end

  def play
    system('clear')
    board.display
    until board.checkmate?(current_player.color)
      play_turn
      switch_player
      system('clear')
      board.display
    end
    puts "#{current_player.color} is in checkmate!".colorize(current_player.color)
    switch_player
    puts "#{current_player.color} wins!".colorize(current_player.color)

  end

  def play_turn
    puts "#{current_player.color}'s turn".colorize(current_player.color)
    start_pos, piece = get_valid_start_pos
    end_pos = get_valid_end_pos(start_pos, piece)

    board.move(start_pos, end_pos)
  end

  def get_valid_start_pos
    begin
      start_pos = current_player.get_start_pos
      piece = board[start_pos]
      raise NilPieceError if piece.nil?
      raise NoValidMovesError if !piece.has_valid_moves?
    rescue NilPieceError
      puts "Nil cell!"
      retry
    rescue NoValidMovesError
      puts "No valid moves for this piece!"
      retry
    end
    [start_pos, piece]
  end

  def get_valid_end_pos(start_pos, piece)
    begin
      end_pos = current_player.get_end_pos
      raise NotValidMoveError if !piece.valid_moves.include?(end_pos)
    rescue NotValidMoveError
      puts "You can't move there."
      retry
    end
    end_pos
  end

  def switch_player
    self.current_player = current_player == player1 ? player2 : player1
  end
end

class Player
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

  def get_start_pos
    ask_for_input('Enter the position of the piece you want to move, e.g. "2,2"')
  end

  def get_end_pos
    ask_for_input('Enter the destination position, e.g. "2,2"')
  end

  def ask_for_input(message)
    begin
      # puts 'Enter the destination position, e.g. "f4"'.colorize(color)
      puts message.colorize(color)
      input = gets.chomp
      # raise "invalid length" if input.length != 2
      raise InputLengthError.new if input.length != 2
      input = input.split('')
      # raise 'wrong input' if LETTER_MAP[input.first].nil? || NUMBER_MAP[input.last].nil?
      raise InputContentError.new if LETTER_MAP[input.first].nil? || NUMBER_MAP[input.last].nil?
    rescue InputLengthError
      puts "Invalid length!"
      retry
    rescue InputContentError
      puts "Invalid content!"
      retry
    end
    [NUMBER_MAP[input.last], LETTER_MAP[input.first]]
  end

end

class InputLengthError < StandardError
end

class InputContentError < StandardError
end

class NilPieceError < StandardError
end

class NoValidMovesError < StandardError
end

class NotValidMoveError < StandardError
end

if __FILE__ == $PROGRAM_NAME
  p1 = Player.new("Arthur")
  p2 = Player.new("Ari")
  game = Game.new(p1, p2)
  game.play
end
