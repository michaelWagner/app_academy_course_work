require_relative 'checker_board'
require 'colorize'

class Piece
  attr_reader :color
  attr_accessor :position, :king

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @king = false
  end

  def king?
    @king
  end

  def maybe_promote
    if color == :white && position[0] == 0
      @king = true
    elsif @position[0] == 9
      @king = true
    end
  end

  def move!(move_to)
    @board[move_to] = self
    @board[@position] = nil
    @position = move_to
    maybe_promote
  end

  def move_jump_diffs
    if king?
      [[2, 2], [2, -2], [-2, 2], [-2, -2]]
    elsif color == :red
      [[2, 2], [2, -2]]
    else
      [[-2, 2], [-2, -2]]
    end
  end

  def move_slide_diffs
    if king?
      [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    elsif @color == :red
      [[1, 1], [1, -1]]
    else
      [[-1, 1], [-1, -1]]
    end
  end

  def perform_slide(slide_to)
    if possible_slides.include?(slide_to)
      move!(slide_to)
    else
      raise "Invalid move"
    end
  end

  def perform_jump(jump_to)
    if possible_jumps.include?(jump_to) # and not jumping over own color
      remove_jumped_piece(@position, jump_to)
      move!(jump_to)
    else
      raise "Invalid move"
    end
  end

  def possible_jumps
    moves = []
    move_jump_diffs.each do |jump_diff|
      x, y = [@position.first + jump_diff.first, @position.last + jump_diff.last]
      jump_move = [x, y]

      if (x.between?(0, 9) && y.between?(0, 9)) && @board[jump_move].nil?
        moves << jump_move
      end
    end

    moves.uniq
  end

  def possible_slides
    moves = []

    move_slide_diffs.each do |slide_diff|
      x, y = [@position.first + slide_diff.first, @position.last + slide_diff.last]
      slide_move = [x, y]

      if (x.between?(0, 9) && y.between?(0, 9)) && @board[slide_move].nil?
        moves << slide_move
      else
      end
    end

    moves.uniq
  end

  def remove_jumped_piece(start_pos, end_pos)
    first = end_pos.first > start_pos.first ? 1 : -1
    last = end_pos[1].to_i > start_pos[1].to_i ? 1 : -1
    jumped_pos = [end_pos[0] - first, end_pos[1] - last]

    p "#{jumped_pos} has been removed"
    @board[jumped_pos] = nil
  end
end
