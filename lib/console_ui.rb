# frozen_string_literal: true

# formats output and collects player input
class ConsoleUI

  def print_board(board)
    puts '╭─────────────╮'
    puts board_body(board)
    puts '├─────────────┤'
    puts '╽1 2 3 4 5 6 7╽'
    puts '┸             ┸'
  end

  def out(string)
    puts string
  end

  def player_move(open_columns)
    move = 0
    until valid_move?(move, open_columns)
      puts "Enter an open column number play your piece: #{open_columns}"
      move = gets.chomp.to_i
    end
    move
  end

  def valid_move?(input, open_columns)
    return false if input.class != Integer

    open_columns.include?(input)
  end

  private

  def board_body(board)
    pieces = { -1 => '⚆', 0 => ' ', 1 => '⚈' }
    body = ''
    (0..5).reverse_each do |i|
      body += '│'
      board.each do |arr|
        body += pieces[arr[i]] + '│'
      end
      body += "\n"
    end
    body
  end

end
