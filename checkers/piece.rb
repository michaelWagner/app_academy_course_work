require_relative 'checker_board'
require 'colorize'
require 'byebug'

class Piece
  attr_reader :color, :position

  def initialize(position, color, board)
    @position = position
    @color = color
    @board = board
    @king = false
  end

  def maybe_promote
  end

  def move!(move_to)
    @board[move_to] = self
    @board[@position] = nil
    @position = move_to
  end

  def move_jump_diffs
    if @color == :red
      [[2, 2], [2, -2]]
    elsif @king
      [[2, 2], [2, -2], [-2, 2], [-2, -2]]
    else
      [[-2, 2], [-2, -2]]
    end
  end

  def move_slide_diffs
    if @color == :red
      [[1, 1], [1, -1]]
    elsif @king
      [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    else
      [[-1, 1], [-1, -1]]
    end
  end

  def perform_slide(slide_to)
    if valid_move?(slide_to)
      move!(slide_to)
    else
      raise "Invalid Slide"
    end
  end

  def perform_jump(jump_to)
    if valid_move?(jump_to)
      remove_jumped_piece(@position, jump_to)
      move!(jump_to)
      # remove jumped piece
    else
      raise "Invalid Jump"
    end
  end


  def possible_moves(pos)
    moves = []

    move_slide_diffs.each do |slide_diff|
      slide_move = @board[[pos.first + slide_diff.first, pos.last + slide_diff.last]]
      unless slide_move.nil?
        moves << slide_move.position
      end
    end

    move_jump_diffs.each do |jump_diff|
      jump_move = @board[[pos.first + jump_diff.first, pos.last + jump_diff.last]]
      unless jump_move.nil?
        p jump_move.position
        moves << jump_move.position
      end
    end

    moves
  end

  def remove_jumped_piece(starting_pos, ending_pos)

  end

  def valid_move?(to_pos)
    if @board[to_pos].nil?
      # need to check jumped over for color @board[to_pos].color != color
      if possible_moves(@position).include?(to_pos)
        return true
      end
    end

    return true
  end
end
