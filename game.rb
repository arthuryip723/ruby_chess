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
      system('clear')
      board.display
      # switch_player
    end

    # puts "Someone wins! Fix this later!"
    puts "#{current_player.color} is in checkmate!".colorize(current_player.color)
    switch_player
    puts "#{current_player.color} wins!".colorize(current_player.color)

  end

  def play_turn
    puts "#{current_player.color}'s turn".colorize(current_player.color)
    start_pos = current_player.get_start_pos
    piece = board[start_pos]
    until piece.has_valid_moves?
      puts "You can't move that piece.".colorize(current_player.color)
      start_pos = current_player.get_start_pos
      piece = board[start_pos]
      # p piece.pos
    end
    # p piece
    # p piece.pos
    # p piece.valid_moves
    # p piece.pos
    end_pos = current_player.get_end_pos
    until piece.valid_moves.include?(end_pos)
      # p end_pos
      puts "You can't move there.".colorize(current_player.color)
      end_pos = current_player.get_end_pos
    end

    board.move(start_pos, end_pos)
    switch_player
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
    # puts 'Enter the position of the piece you want to move, e.g. "2,2"'.colorize(color)
    puts 'Enter the position of the piece you want to move, e.g. "f2"'.colorize(color)
    # gets.split(',').map(&:chomp).map(&:to_i)
    input = gets.chomp.split('')
    [NUMBER_MAP[input.last], LETTER_MAP[input.first]]
  end

  def get_end_pos
    # puts 'Enter the destination position, e.g. "2,2"'.colorize(color)
    puts 'Enter the destination position, e.g. "f4"'.colorize(color)
    # gets.split(',').map(&:chomp).map(&:to_i)
    input = gets.chomp.split('')
    [NUMBER_MAP[input.last], LETTER_MAP[input.first]]
  end



end

if __FILE__ == $PROGRAM_NAME
  p1 = Player.new("Arthur")
  p2 = Player.new("Ari")
  game = Game.new(p1, p2)
  game.play
end
