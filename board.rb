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

  LETTER_MAP = {
    0 => 'a',
    1 => 'b',
    2 => 'c',
    3 => 'd',
    4 => 'e',
    5 => 'f',
    6 => 'g',
    7 => 'h'
  }

  NUMBER_MAP = {
    0 => '1',
    1 => '2',
    2 => '3',
    3 => '4',
    4 => '5',
    5 => '6',
    6 => '7',
    7 => '8'
  }

  attr_reader :grid

  def initialize()
    @grid = Array.new(SIZE) { Array.new(SIZE) }
    populate_board
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

  def on_board_and_not_occupied_by_self(positions, color)
    not_occupied_by_self(Board.select_on_board(positions), color)
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
    puts '  '+(0...SIZE).to_a.map { |num| LETTER_MAP[num] }.join(' ')
    @grid.each_with_index do |row, idx|
      puts NUMBER_MAP[idx]+' '+row.map{|el| el.nil? ? '-' : el.to_s}.join(' ') + ' ' + NUMBER_MAP[idx]
    end
    puts '  '+(0...SIZE).to_a.map { |num| LETTER_MAP[num] }.join(' ')
  end

  def checkmate?(color)
    own_pieces(color).none? { |piece| piece.has_valid_moves? }
  end

  def in_check?(color)
    king = king(color)
    opponent_pieces(color).any? do |piece|
      piece.moves.include?(king.pos)
    end
  end

  def deep_dup
    new_board = self.dup
    new_grid = Array.new(SIZE) { Array.new(SIZE) }
    grid.each_with_index do |row, idx1|
      row.each_with_index do |piece, idx2|
        new_grid[idx1][idx2] = grid[idx1][idx2].deep_dup(new_board) unless
          grid[idx1][idx2].nil?
      end
    end
    new_board.grid = new_grid
    new_board
  end

  def own_pieces(color)
    result = []
    grid.flatten.each { |cell| result << cell if cell && cell.color == color}
    result
  end

  protected
  attr_writer :grid

  private

  def king(color)
    grid.flatten.select {|piece| !piece.nil? && piece.is_a?(King) &&
      piece.color == color }.first
  end

  def self.select_on_board(positions)
    positions.select{ |pos| Board.on_board?(pos)}
  end

  def not_occupied_by_self(positions, color)
    positions.select{ |pos| self[pos].nil? || self[pos].color != color }
  end

  def opponent_pieces(color)
    result = []
    grid.flatten.each { |cell| result << cell if cell && cell.color != color}
    result
  end

  def populate_board
    grid.each_with_index do |row, idx1|
      row.each_index do |idx2|
        color = idx1 >= SIZE / 2 ? Game::COLORS[0] : Game::COLORS[1]
        class_symbol = LAYOUT[idx1][idx2]

        grid[idx1][idx2] = class_symbol ?
          class_symbol.new(color, [idx1, idx2], self) : nil
      end
    end
  end

end
