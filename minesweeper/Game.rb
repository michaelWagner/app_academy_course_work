require_relative 'Board'
require_relative 'Tile'
require 'yaml'

class Game
  #
  # def initialize(grid_size = 9)
  #   puts "Welcome to the minesweeeper game"
  #   @grid_size = grid_size
  #   @board = Board.new(grid_size)
  #   @board.display
  # end

  def initialize(grid_size = 9, saved_game = {})
    puts "Welcome to the minesweeeper game"
    @grid_size = grid_size
    unless saved_game[@board].nil?
      @board = saved_game[@board]
    else
      @board = Board.new(grid_size)
    end
    @board.display
  end

  def play
    game_over = false
    until game_over
      puts "Current board: "
      @board.display
      input = get_input
      process_input(input)
      game_over = over?
    end
  end

  def get_input
    puts "\"r\" chooses to reveal a tile"
    puts "\"f\" chooses to flag a tile"
    puts "\"save\" to save game"
    puts "q to quit"
    choice = "hi"
    until valid_input?(choice)
      puts "Enter in the format of: r y,x"
      choice = gets.chomp.downcase
    end
    if choice == "save" || choice == "q"
      save(choice)
    else
      match_groups = /([rf])\s*(\d+),\s*(\d+)/.match(choice)
      return [match_groups[1], match_groups[2], match_groups[3]]
    end

  end


  def over?
    #reveal a bomb = lose
    #entire board is not flagged or revealed yet == continue playing
    #flagged correct number of bombs & previous conditions applied
    flag_count = 0
    unrevealed = false
    @board.minesweeper_board.each_index do |y|
      @board.minesweeper_board.each_index do |x|
        tile = @board.minesweeper_board[y][x]
        if tile.bombed == 1 && tile.revealed
          puts "You lose"
          @board.display
          @board = Board.new(@grid_size)
          return true
        elsif tile.revealed == false && tile.flagged == false
          unrevealed = true
        elsif tile.flagged == true && tile.bombed == 1
          flag_count += 1
        end
      end
    end
    if unrevealed
      return false
    elsif flag_count == @board.total_bomb_count
      puts "you win!"
      return true
    end
  end


  def process_input(input)
    action, y, x = input
    y = y.to_i
    x = x.to_i
    tile = @board.minesweeper_board[y][x]
    if action == "r" && !tile.flagged
      tile.execute_reveal
    elsif action == "f"
      tile.flag
    end
  end

  def valid_input?(choice)
    if choice == "save" || choice == "q"
      return true
    end
    match_groups = /([rf])\s*(\d+),\s*(\d+)/.match(choice)
    unless match_groups == nil
      if match_groups[2].to_i < @grid_size && match_groups[3].to_i < @grid_size
        return true
      end
    end
    false
  end

  def save(choice)
    puts "Enter a filename: "
    filename = gets.chomp
    File.open(filename, 'w') do |f|
      f.puts self.to_yaml
    end
    if choice == "q"
      exit
    end
  end

  def self.load(yaml_file)
    YAML.load_file(yaml_name)
  end
end

if __FILE__ == $PROGRAM_NAME
  filename = ARGV.shift
  if filename.nil?
    g = Game.new
    g.play
  else
    Game.load(filename)
  end
end
