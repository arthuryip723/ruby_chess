class Board
  SIZE = 8
  def initialize
    @grid = Array.new(SIZE) { Array.new(SIZE) }
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

end
