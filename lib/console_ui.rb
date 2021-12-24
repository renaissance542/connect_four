# frozen_string_literal: true

# formats output and collects player input
class ConsoleUI
  # rubocop:disable all

  def print_board(board)
    pieces = { -1 => '⚆', 0 => ' ', 1 => '⚈' }
    
    puts "╭─────────────╮"
    (0..5).reverse_each do |i|
      line = '│'
      board.each do |arr|
        line += pieces[arr[i]] + '│'
      end
      puts line
    end
    puts "├─────────────┤"
    puts "╽1 2 3 4 5 6 7╽"
    puts "┸             ┸"
  end

end
