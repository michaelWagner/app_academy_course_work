require_relative 'Board'
require_relative 'Game'

class Tile
  NEIGHBORS = [[0, 1], [0, -1], [1, 0], [-1, 0],
               [1, 1], [1, -1], [-1, 1], [-1, -1]]
  attr_reader :bombed, :revealed
  attr_accessor :flagged

  def initialize(board, bombed, coordinates)
    @board = board
    @bombed = bombed
    @revealed = false
    @flagged = false
    @coordinates = coordinates
  end

  def reveal
    @revealed = true
  end

  def execute_reveal
    if neighbor_bomb_count > 0
      self.reveal
    else
      self.reveal
      self.neighbors.each do |coordinates|
        neighbor = @board.minesweeper_board[coordinates[0]][coordinates[1]]
        neighbor.execute_reveal unless neighbor.revealed
      end
    end
  end

  def neighbors
    NEIGHBORS.map do |change|
      [@coordinates[0] + change[0], @coordinates[1] + change[1]]
    end
    .reject do |coordinates|
      coordinates[0] >= @board.grid_size ||
      coordinates[0] <  0 ||
      coordinates[1] >= @board.grid_size ||
      coordinates[1] < 0
    end
  end

  def neighbor_bomb_count
    neighbor_bomb_count = 0
    neighbors.each do |tile|
      this_tile = @board.minesweeper_board[tile[0]][tile[1]]
      neighbor_bomb_count += 1 if this_tile.bombed == 1
    end
    neighbor_bomb_count
  end

  def inspect
    puts "Tile #{@coordinates}: bombed: #{@bombed},

    revealed: #{@revealed}, flagged: #{@flagged}"
  end

  def flag
    if @flagged == false
      @flagged = true
    else
      @flagged = false
    end
  end
end
