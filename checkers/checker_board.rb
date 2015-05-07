require_relative 'piece'
require_relative 'keypress'

class CheckerBoard
  attr_accessor :board, :cursor
  attr_reader :white_pieces, :red_pieces

  def initialize
    @cursor = [0, 0]
    @board = create_board
    @white_pieces = []
    @red_pieces = []
    fill_board
    render
  end

  def [](pos)
    x, y = pos
    self.board[x][y]
  end

  def []=(pos, value)
    x, y = pos
    self.board[x][y] = value
  end

  def create_board
    Array.new(10) { Array.new(10) }
  end

  def fill_board
    (0..9).each do |row|
      (0..9).each do |col|
        if row < 4 || row > 5
          color = row < 5 ? :red : :white
          if (row + col) % 2 != 0
            self[[row, col]] = Piece.new([row, col], color, self)
            # Add reference to a players total colection of pieces
            if self[[row, col]].color == :white
              self.white_pieces << self[[row, col]]
            else
              self.red_pieces << self[[row, col]]
            end
          end
        end
      end
    end
  end

  def move_cursor
    seq = []

    loop do
      input = read_char
      x, y = @cursor

      case input
      when "\r"
        return @cursor
      when "\e[A"
        if (x - 1).between?(0, 9) && (y).between?(0,9)
          self.cursor = [x - 1, y]
        end
      when "\e[B"
        if (x + 1).between?(0, 9) && (y).between?(0,9)
          self.cursor = [x + 1, y]
        end
      when "\e[C"
        if (x).between?(0, 9) && (y + 1).between?(0,9)
          self.cursor = [x, y + 1]
        end
      when "\e[D"
        if (x).between?(0, 9) && (y - 1).between?(0,9)
          self.cursor = [x, y - 1]
        end
      when "\u0003"
        puts "Game over"
        exit 0
      end

      system "clear"
      render
    end
  end

  def pieces(color)
    color == :red ? @red_pieces : @white_pieces
  end

  def render
    print "\n"
    (0..9).each do |row|
      (0..9).each do |col|
        if (row + col) % 2 != 0
          if self[[row, col]].nil?
            if [row, col] == cursor
              print "   ".colorize(:background => :yellow)
            else
              print "   ".colorize(:background => :blue)
            end
          else
            if [row, col] == cursor
              print " O ".colorize(:color => "#{self[[row, col]].color}".to_sym,
                                   :background => :yellow)
            else
              print " O ".colorize(:color => "#{self[[row, col]].color}".to_sym,
                                   :background => :blue)
            end
          end
        else
          if [row, col] == cursor
            print "   ".colorize(:background => :yellow)
          elsif self[[row, col]].nil?
            print "   "
          else
            print " O ".colorize(:color => "#{self[[row, col]].color}".to_sym)
          end
        end
      end
      print "\n"
    end
    print "\n"
  end

end

if __FILE__ == $PROGRAM_NAME
  c = CheckerBoard.new
  # system 'clear'
  # test cases
  #
  # r1 = c[[3, 2]]
  # r1.perform_slide([4, 3])
  # c.render
  #
  # w2 = c[[6, 1]]
  # w2.perform_slide([5, 2])
  # c.render
  #
  # r1.perform_jump([6, 1])
  # c.render
  #
  # w3 = c[[7, 0]]
  # w3.perform_jump([5, 2])
  # c.render
  #
  # w4 = c[[6, 3]]
  # w4.perform_slide([5, 4])
  # c.render
  #
  # r5 = c[[3, 4]]
  # r5.perform_slide([4, 5])
  # c.render
  #
  # r5.perform_jump([6, 3])
  # c.render
  #
  # w6 = c[[7, 2]]
  # w6.perform_jump([5, 4])
  # c.render
  #
  # w8 = c[[8, 1]]
  # w8.perform_slide([7, 2])
  # c.render
  #
  # w9 = c[[9, 2]]
  # w9.perform_slide([8, 1])
  # c.render
  #
  # w9.perform_slide([7, 0])
  # c.render
  #
  # r10 = c[[3, 6]]
  # r10.perform_slide([4, 5])
  # c.render
  #
  # r10.perform_jump([6, 3])
  # c.render
  #
  # r10.perform_jump([8, 1])
  # c.render
  #
  # r10.perform_slide([9, 2])
  # c.render
  #
  # w11 = c[[7, 4]]
  # w11.perform_slide([6, 3])
  # c.render
  #
  # r10.perform_jump([7, 4])
  # c.render
  #
  # r10.perform_slide([8, 3])
  # c.render

end
