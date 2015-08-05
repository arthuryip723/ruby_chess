require_relative 'board'
require_relative 'human_player'
# require_relative 'errors'

class Game
  COLORS = [:blue, :red]

  attr_reader :board, :player1, :player2
  attr_accessor :current_player
  def initialize(player1, player2)
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

  private

  def play_turn
    puts "#{current_player.color}'s turn".colorize(current_player.color)
    # start_pos, piece = get_valid_start_pos
    # end_pos = get_valid_end_pos(start_pos, piece)
    start_pos, end_pos = current_player.get_move(board)

    board.move(start_pos, end_pos)
  end

  # def get_valid_start_pos
  #   begin
  #     start_pos = current_player.get_start_pos
  #     piece = board[start_pos]
  #     raise NilPieceError if piece.nil?
  #     raise NoValidMovesError if !piece.has_valid_moves?
  #   rescue NilPieceError
  #     puts "That position is empty"
  #     retry
  #   rescue NoValidMovesError
  #     puts "No valid moves for this piece!"
  #     retry
  #   end
  #   [start_pos, piece]
  # end
  #
  # def get_valid_end_pos(start_pos, piece)
  #   begin
  #     end_pos = current_player.get_end_pos
  #     raise NotValidMoveError if !piece.valid_moves.include?(end_pos)
  #   rescue NotValidMoveError
  #     puts "You can't move there."
  #     retry
  #   end
  #   end_pos
  # end

  def switch_player
    self.current_player = current_player == player1 ? player2 : player1
  end
end


if __FILE__ == $PROGRAM_NAME
  p1 = HumanPlayer.new("Arthur")
  p2 = HumanPlayer.new("Ari")
  game = Game.new(p1, p2)
  game.play
end
