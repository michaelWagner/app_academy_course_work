require_relative 'piece'

class CheckerBoard
  attr_reader :board

  def initialize #board = false)
    @board = create_board #unless board
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
          end
        end
      end
    end
  end

  def render
    print "\n"
    (0..9).each do |row|
      (0..9).each do |col|
        if (row + col) % 2 != 0
          if self[[row, col]].nil?
            print "   ".colorize(:background => :blue)
          else
            print " O ".colorize(:color => "#{self[[row, col]].color}".to_sym,
                                 :background => :blue)
          end
        else
          if self[[row, col]].nil?
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
  system 'clear'
  c.render
  p1 = c[[0, 1]]

  p1.perform_slide([0, 2])

  c.render

  p2 = c[[0, 3]]

  p2.perform_jump([4, 2])
  
  c.render
end
