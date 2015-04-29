require_relative 'Tile'
require_relative 'Game'

class Board
  MAX_MINES =  5 # (9 * 9) / 3
  attr_reader :total_bomb_count, :grid_size
  attr_accessor :minesweeper_board

  def initialize(grid_size)
    @minesweeper_board = build_board(grid_size)
    @grid_size = grid_size
  end

  def build_board(grid_size)
    @total_bomb_count = 0
    bombed = false
    minesweeper_board = Array.new(grid_size) { Array.new(grid_size) }
    minesweeper_board.each_index do |y|
      minesweeper_board.each_index do |x|
        if @total_bomb_count < MAX_MINES
          bombed = [false, true].sample
          # p bombed
          if bombed == true
            @total_bomb_count += 1
          end
        end
        minesweeper_board[y][x] = Tile.new(self, [y,x], bombed)
        bombed = false
      end
    end
    puts @total_bomb_count
    minesweeper_board
  end

  def display
    minesweeper_board.each_index do |y|

      minesweeper_board.each_index do |x|
        tile = minesweeper_board[y][x]
        unless tile.flagged
          unless tile.revealed
            print " * "
          else
            if tile.bombed
              print " B "
            elsif tile.neighbor_bomb_count > 0
              print " #{tile.neighbor_bomb_count} "
            else
              print " _ "
            end
          end
        else
          print " F "
        end
      end
      print "\n"
    end
    nil
  end
end
