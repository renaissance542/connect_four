# frozen_string_literal: true
# rubocop:disable Metrics/BlockLength

require_relative '../lib/gameboard'

system("cls") || system("clear")

describe Gameboard do
  subject(:game) { described_class.new }

  describe '#move(column)' do
    context "when the move is column 2 on player one's turn" do
      before do
        game.instance_variable_set(:@player_one_turn, true)
        game.move(2)
      end

      it 'adds a value to the array in column 2' do
        value = game.board[1][0]
        expect(value).to_not be_nil
      end

      it 'the value added is 1' do
        value = game.board[1][0]
        expect(value).to eq(1)
      end
    end

    context 'when the first 2 moves are made in a row' do
      before do
        game.instance_variable_set(:@player_one_turn, true)
        game.move(3)
        game.move(3)
      end

      it 'the first value added is 1' do
        value = game.board[2][0]
        expect(value).to eq(1)
      end

      it 'the seconds value added is -1' do
        value = game.board[2][1]
        expect(value).to eq(-1)
      end
    end
  end

  describe '#game_over?' do
    # only runs if @game_over is false

    context 'when there is no win' do
      before do
        no_win = [
          [-1, 1, 1, -1, 1, 0],
          [1, -1, 1, -1, 0, 0],
          [1, -1, -1, 0, 0, 0],
          [-1, 1, 1, 0, 0, 0],
          [1, -1, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0],
          [-1, 1, -1, 1, -1, 0]
        ]
        game.instance_variable_set(:@board, no_win)
      end
      it 'returns false' do
        expect(game.game_over?).to be false
      end
    end

    context 'when player 1 has win in column 1' do
      before do
        vert_win = [
          [-1, 1, 1, 1, 1, 0],
          [1, -1, 1, -1, 0, 0],
          [1, -1, -1, 0, 0, 0],
          [-1, 1, 1, 0, 0, 0],
          [1, -1, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0]
        ]
        game.instance_variable_set(:@board, vert_win)
      end
      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'when player 2 has win in column 7' do
      before do
        vert_win = [
          [-1, 1, -1, 1, 1, 0],
          [1, -1, 1, -1, 0, 0],
          [1, -1, -1, 0, 0, 0],
          [-1, 1, 1, 0, 0, 0],
          [1, -1, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0],
          [1, -1, -1, -1, -1, 0]
        ]
        game.instance_variable_set(:@board, vert_win)
      end
      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'when there is no win' do
      before do
        horz_win = [
          [-1, 1, 1, -1, 1, 0],
          [1, -1, 1, -1, 0, 0],
          [1, -1, -1, 0, 0, 0],
          [-1, 1, 1, 0, 0, 0],
          [1, -1, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0],
          [-1, 1, -1, -1, -1, 0]
        ]
        game.instance_variable_set(:@board, horz_win)
      end

      it 'returns false' do
        expect(game.game_over?).to be false
      end
    end

    context 'when player 1 has win in row 1' do
      before do
        horz_win = [
          [-1, -1, -1, -1, 1, 0],
          [-1, -1, -1, -1, 0, 0],
          [1, -1, -1, 0, 0, 0],
          [1, 1, 1, 0, 0, 0],
          [1, -1, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0],
          [-1, -1, -1, -1, -1, 0]
        ]
        game.instance_variable_set(:@board, horz_win)
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'when player 2 has win in row 7' do
      before do
        horz_win = [
          [-1, -1, -1, -1, 1, 0],
          [-1, -1, -1, -1, 0, 0],
          [1, -1, -1, 0, 0, -1],
          [-1, 1, 1, 0, 0, -1],
          [1, -1, 0, 0, 0, -1],
          [1, 0, 0, 0, 0, -1],
          [-1, -1, -1, -1, -1, 0]
        ]
        game.instance_variable_set(:@board, horz_win)
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'where player 2 wins upward diagonal from col 1, row 1' do
      before do
        diag_win = [
          [-1, 1, 1, -1, 1, 0],
          [1, -1, 1, -1, 0, 0],
          [1, -1, -1, 0, 0, 0],
          [-1, 1, 1, -1, 0, 0],
          [1, -1, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0],
          [-1, 1, 1, -1, -1, 1]
        ]
        game.instance_variable_set(:@board, diag_win)
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'where player 1 wins downward diagonal from col 1, row 6' do
      before do
        diag_win = [
          [1, 1, 1, -1, 1, 1],
          [1, -1, 1, -1, 1, 0],
          [1, -1, -1, 1, 0, 0],
          [-1, 1, 1, -1, 0, 0],
          [1, -1, 0, 0, 0, 0],
          [1, 0, 0, 0, 0, 0],
          [-1, 1, 1, -1, -1, 1]
        ]
        game.instance_variable_set(:@board, diag_win)
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end

    context 'where player 2 wins upward diagonal from col 4, row 1' do
      before do
        diag_win = [
          [1, 0, 1, -1, 1, 0],
          [0, -1, 1, -1, 1, 0],
          [1, -1, -1, 1, 0, 0],
          [-1, 1, 1, -1, 0, 0],
          [1, -1, 0, 0, 0, 0],
          [1, 1, -1, 0, 0, 0],
          [-1, 1, 1, -1, 0, 0]
        ]
        game.instance_variable_set(:@board, diag_win)
      end

      it 'returns true' do
        expect(game.game_over?).to be true
      end
    end
  end

  describe '#open_columns' do
    context 'when columns 2 and 5 are full' do
      before do
        full_cols = [
          [1, 0, 1, -1, 1, 0],
          [-1, -1, 1, -1, 1, 1],
          [1, -1, -1, 1, 0, 0],
          [1, 1, 1, -1, 0, 0],
          [1, -1, 1, 1, -1, -1],
          [1, 1, -1, 0, 0, 0],
          [-1, 1, 1, -1, 0, 0]
        ]
        game.instance_variable_set(:@board, full_cols)
      end

      it 'returns [1, 3, 4, 6, 7]' do
        result = [1, 3, 4, 6, 7]
        expect(game.open_columns).to eq(result)
      end
    end
  end
end
