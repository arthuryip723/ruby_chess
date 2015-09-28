require_relative 'lib/board'
require_relative 'lib/human_player'
require_relative 'lib/computer_player'
require_relative 'lib/errors'
# require_relative 'lib'

class Game
  COLORS = [:blue, :red]

  CLEAR = true #for testing

  attr_reader :board, :player1, :player2
  attr_accessor :current_player
  def initialize(player1, player2)
    @player1, @player2 = player1, player2
    player1.color = COLORS[0]
    player2.color = COLORS[1]
    @current_player = player2
    @board = Board.new
    @last_turn = nil
  end

  def play
    system('clear') if CLEAR
    board.display
    until board.checkmate?(current_player.color)
      play_turn
      switch_player
      system('clear') if CLEAR
      board.display
    end
    show_last_move
    puts "#{current_player.color} is in checkmate!".colorize(current_player.color)
    switch_player
    puts "#{current_player.color} wins!".colorize(current_player.color)

  end

  private

  def play_turn
    show_last_move
    puts "#{current_player.color}'s turn".colorize(current_player.color)
    start_pos, end_pos = current_player.get_move(board)
    @last_turn = [start_pos, end_pos]
    board.move(start_pos, end_pos)
  end

  def show_last_move
    return if @last_turn.nil?
    start_pos_letter = Board::LETTER_MAP[ @last_turn[0][1] ]
    start_pos_number = Board::NUMBER_MAP[ @last_turn[0][0] ]
    end_pos_letter = Board::LETTER_MAP[ @last_turn[1][1] ]
    end_pos_number = Board::NUMBER_MAP[ @last_turn[1][0] ]

    start_pos = "#{start_pos_letter}#{start_pos_number}"
    end_pos = "#{end_pos_letter}#{end_pos_number}"
    puts "Last player's turn: #{start_pos} to #{end_pos}"
  end

  def switch_player
    self.current_player = current_player == player1 ? player2 : player1
  end
end


if __FILE__ == $PROGRAM_NAME
  # p1 = HumanPlayer.new("Arthur")
  p1 = ComputerPlayer.new("Arthur")
  p2 = HumanPlayer.new("Ari")
  game = Game.new(p1, p2)
  game.play
end
