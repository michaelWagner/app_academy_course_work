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

  def move_diffs
  end

  def perform_slide(slide_to)
    # unless valid_move?(slide_to)
    @board[slide_to] = self
    @board[@position] = nil
    @position = slide_to
    # else
      # raise "Invalid Move"
    # end

  end

  def perform_jump(jump_to)

    @board[jump_to] = self
    @board[@position] = nil
    @position = jump_to
  end

  def valid_move?(to_pos)
    # unless @board[to_pos].nil?
      # if moves.include?(to_pos) && @board[to_pos].color != color
        # perform_move!()
  end

end
