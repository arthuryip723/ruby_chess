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
    current_player = player1
    @board = Board.new
  end

  def play
    system('clear')
    board.display
    until board.over?
      play_turn
      board.display
      switch_player
    end

    puts "Someone wins! Fix this later!"
  end

  def play_turn
    start_pos = current_player.get_move
    end_pos = current_player.get_move
    board.move(start_pos, end_pos)
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

  def get_move

  end

end

if __FILE__ == $PROGRAM_NAME
  p1 = Player.new("Arthur")
  p2 = Player.new("Ari")
  game = Game.new(p1, p2)
  game.board.display
end
