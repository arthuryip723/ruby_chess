require_relative 'piece'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'
require_relative 'game'

class Board
  SIZE = 8

  LAYOUT = [
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook],
    Array.new(SIZE) {Pawn},
    Array.new(SIZE) {nil},
    Array.new(SIZE) {nil},
    Array.new(SIZE) {nil},
    Array.new(SIZE) {nil},
    Array.new(SIZE) {Pawn},
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  ]

  attr_accessor :grid

  def initialize(grid = nil)
    @grid = Array.new(SIZE) { Array.new(SIZE) }
    grid.nil? ? populate_board : @grid = grid
  end

  def in_check?(color)
  end

  def move(start, end_pos)
    piece = self[start]
    # p piece.moves
    self[end_pos] = piece
    piece.pos = end_pos
    self[start] = nil
  end

  def self.on_board?(pos)
    pos.all?{ |coord| coord.between?(0, SIZE - 1) }
  end

  def self.select_on_board(positions)
    positions.select{ |pos| Board.on_board?(pos)}
  end

  def not_occupied_by_self(positions, color)
    positions.select{ self[pos].nil? || self[pos].color != color }
  end

  def on_board_and_not_occupied(positions, color)
    not_occupied_by_self(select_on_board(positions), color)
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def display
    puts '  '+(0...SIZE).to_a.join(' ')
    @grid.each_with_index do |row, idx|
      puts idx.to_s+' '+row.map{|el| el.nil? ? '-' : el.to_s}.join(' ')
    end
  end

  def populate_board
    # comments
    grid.each_with_index do |row, idx1|
      row.each_index do |idx2|
        color = idx1 >= SIZE / 2 ? Game::COLORS[0] : Game::COLORS[1]
        class_symbol = LAYOUT[idx1][idx2]

        grid[idx1][idx2] = class_symbol ?
          class_symbol.new(color, [idx1, idx2], self) : nil
      end
    end
  end

  def over?
    false
  end

  def in_check?(color)
    king = king(color)
    opponent_pieces(color).any? do |piece|
      piece.moves.include?(king.pos)
    end
  end

  def king(color)
    grid.flatten.select {|piece| !piece.nil? && piece.is_a?(King) &&
      piece.color == color }.first
  end

  def opponent_pieces(color)
    result = []
    grid.flatten.each { |cell| result << cell if cell && cell.color != color}
    result
  end

  def deep_dup
    board = self.dup
    new_grid = Array.new(SIZE) { Array.new(SIZE) }
    grid.each_with_index do |row, idx1|
      row.each_with_index do |piece, idx2|
        new_grid[idx1][idx2] = grid[idx1][idx2].deep_dup(board) unless grid[idx1][idx2].nil?
        # new_grid[idx1][idx2].board = board
      end
    end
    board.grid = new_grid
    board

    # Board.new(new_grid)
  end

end

if __FILE__ == $PROGRAM_NAME

end
