# frozen_string_literal: true
# rubocop:disable Metrics/BlockLength

require_relative '../lib/console_ui'

system("cls") || system("clear")

describe ConsoleUI do
  subject(:consoleUI) { described_class.new }

  describe '#player_move' do
    context 'when the input is 7' do
      before do
        allow(consoleUI).to receive_message_chain(:gets, :chomp, :to_i).and_return(7)
        allow(consoleUI).to receive(:puts)
      end

      it 'returns a number' do
        open_cols = [1, 2, 3, 4, 5, 6, 7]
        expect(consoleUI.player_move(open_cols)).to be_kind_of(Integer)
      end

      it 'calls gets' do
        open_cols = [1, 2, 3, 4, 5, 6, 7]
        expect(consoleUI).to receive(:gets)
        consoleUI.player_move(open_cols)
      end
    end

    context 'when first input is not a number' do
      before do
        allow(consoleUI).to receive_message_chain(:gets, :chomp, :to_i).and_return('G', 4)
        allow(consoleUI).to receive(:puts)
      end

      it 'calls gets twice'do
        open_cols = [1, 2, 3, 4, 5, 6, 7]
        expect(consoleUI).to receive(:gets).twice
        consoleUI.player_move(open_cols)
      end
    end
  end

  describe '#valid_move?' do
    context 'when passed a 6' do
      it 'returns true' do
        open_cols = [1, 2, 3, 4, 5, 6, 7]
        expect(consoleUI.valid_move?(6, open_cols)).to be true
      end
    end

    context 'when passed a letter' do
      it 'returns false' do
        open_cols = [1, 2, 3, 4, 5, 6, 7]
        expect(consoleUI.valid_move?('k', open_cols)).to be false
      end
    end

    context 'when passed an 8' do
      it 'returns false' do
        open_cols = [1, 2, 3, 4, 5, 6, 7]
        expect(consoleUI.valid_move?(8, open_cols)).to be false
      end
    end

    context 'when passed a 2 and column 2 is full' do
      it 'returns false' do
        open_cols = [1, 3, 4, 5, 6, 7]
        expect(consoleUI.valid_move?(2, open_cols)).to be false
      end
    end
  end
end
# player_name_input
# rules_output
# main_menu_output
# player_move_prompt
# player_move_input(playable_columns)
# game_over_message_output

