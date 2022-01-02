# frozen_string_literal: true

# stores boardstate, processes moves, and checks win conditions
class Gameboard
  # these are the starting coordinates of diagonals longer than 3, used in @diagonal_win?
  UPWARD_DIAGONALS = [[0, 0], [0, 1], [0, 2], [1, 0], [2, 0], [3, 0]].freeze
  DOWNWARD_DIAGONALS = [[0, 3], [0, 4], [0, 5], [1, 5], [2, 5], [3, 5]].freeze

  attr_reader :board, :player_one_turn
  def initialize
    @board = Array.new(7) { Array.new(6, 0) }
    @player_one_turn = true
  end

  def move(column)
    # need validation to not overfill column
    value = @player_one_turn ? 1 : -1
    insert_value(value, column)
    @player_one_turn = !@player_one_turn
  end

  def game_over?
    board_full? || game_won?
  end

  def open_columns
    open_cols = []
    @board.each_with_index do |arr, i|
      open_cols << i + 1 if arr.last.zero?
    end
    open_cols
  end

  private

  def board_full?
    # full board has no zeros
    @board.none? { |col| col.include?(0) }
  end

  # This method was designed to take a board state and identify a win.
  # It currently checks all rows/cols/diagonals each time. 6 + 7 + 12 = 25 checks
  # It can be refactored to check only the rows and diagonals
  # which intersect the last move. 1 + 1 + 2 = 4 checks
  def game_won?
    column_win? || row_win? || diagonal_win?
  end

  def column_win?(cols = @board)
    cols.each do |col|
      return true if check_arr(col)
    end
    false
  end

  def row_win?
    transposed_board = @board.transpose # now the rows are columns
    column_win?(transposed_board)
  end

  def diagonal_win?
    column_win?(diagonals_to_columns)
  end

  def diagonals_to_columns
    result = []
    UPWARD_DIAGONALS.each do |pair|
      result << get_diagonal(pair[0], pair[1], 1)
    end
    DOWNWARD_DIAGONALS.each do |pair|
      result << get_diagonal(pair[0], pair[1], -1)
    end
    result
  end

  def get_diagonal(col, row, direction)
    result = []
    while col.between?(0, 6) && row.between?(0, 5)
      result.push(@board[col][row])
      col += 1
      row += direction
    end
    result
  end

  def insert_value(value, column)
    first_zero = @board[column - 1].index(0)
    @board[column - 1][first_zero] = value
  end

  def check_arr(arr)
    arr.each_cons(4) do |four|
      total = four.sum
      # check if it's four 1' or four -1's
      return true if [-4, 4].include?(total)
    end
    false
  end
end
