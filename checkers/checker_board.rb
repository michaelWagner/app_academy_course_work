require_relative 'piece'

class CheckerBoard
  attr_accessor :cursor
  attr_reader :board

  def initialize #board = false)
    @cursor = [0, 0]
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
  # [up/down, left/right]

  r1 = c[[3, 2]]
  r1.perform_slide([4, 3])
  c.render

  w2 = c[[6, 1]]
  w2.perform_slide([5, 2])
  c.render

  r1.perform_jump([6, 1])
  c.render

  w3 = c[[7, 0]]
  w3.perform_jump([5, 2])
  c.render

  w4 = c[[6, 3]]
  w4.perform_slide([5, 4])
  c.render

  r5 = c[[3, 4]]
  r5.perform_slide([4, 5])
  c.render

  r5.perform_jump([6, 3])
  c.render

  w6 = c[[7, 2]]
  w6.perform_jump([5, 4])
  c.render

  w8 = c[[8, 1]]
  w8.perform_slide([7, 2])
  c.render

  w9 = c[[9, 2]]
  w9.perform_slide([8, 1])
  c.render

  w9.perform_slide([7, 0])
  c.render

  r10 = c[[3, 6]]
  r10.perform_slide([4, 5])
  c.render

  r10.perform_jump([6, 3])
  c.render

  r10.perform_jump([8, 1])
  c.render

  r10.perform_slide([9, 2])
  c.render

  w11 = c[[7, 4]]
  w11.perform_slide([6, 3])
  c.render

  r10.perform_jump([7, 4])
  c.render

  r10.perform_slide([8, 3])
  c.render

end
