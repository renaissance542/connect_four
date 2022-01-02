# frozen_string_literal: true

require_relative 'gameboard'
require_relative 'console_ui'
require 'pry-byebug'

# game logic 
class ConnectFour
  RULES = <<~RULES
    Welcome to Connect Four.
    In this game you take turns dropping pieces into the board
    from the top. You win by being the first to get four of
    your pieces in a row: horizontally, vertically, or diagonally.
  RULES

  def initialize
    @ui = ConsoleUI.new
  end

  def rules
    @ui.out(RULES)
  end

  def play
    @gameboard = Gameboard.new
    @ui.print_board(@gameboard.board)
    until @gameboard.game_over?
      # player enters a number between 1-7
      @gameboard.move(@ui.player_move(@gameboard.open_columns))
      system("cls") || system("clear")
      @ui.print_board(@gameboard.board)
    end
    @ui.out(game_over_message)
  end

  private

  def game_over_message
    winner = @gameboard.player_one_turn ? '2 (black pieces)' : '1 (white pieces)'
    "Game Over.  Player #{winner} won.\n"
  end

end
