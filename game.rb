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
    @current_player = player1
    @board = Board.new
  end

  def play
    # system('clear')
    board.display
    until board.over?

      play_turn
      # system('clear')
      board.display
      # switch_player
    end

    puts "Someone wins! Fix this later!"
  end

  def play_turn
    puts "#{current_player.color}'s turn"
    start_pos = current_player.get_start_pos
    end_pos = current_player.get_end_pos
    board.move(start_pos, end_pos)
    switch_player
  end

  def switch_player
    self.current_player = current_player == player1 ? player2 : player1
  end
end

class Player

  attr_reader :name
  attr_accessor :color
  def initialize(name)
    @name = name
  end

  def get_start_pos
    puts 'Enter the position of the piece you want to move, e.g. "2,2"'
    gets.split(',').map(&:chomp).map(&:to_i)
  end

  def get_end_pos
    puts 'Enter the destination position, e.g. "2,2"'
    gets.split(',').map(&:chomp).map(&:to_i)
  end



end

if __FILE__ == $PROGRAM_NAME
  p1 = Player.new("Arthur")
  p2 = Player.new("Ari")
  game = Game.new(p1, p2)
  game.play
end
