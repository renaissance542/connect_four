# frozen_string_literal: true
# rubocop:disable Metrics/BlockLength

require_relative '../lib/connect_four'
require_relative '../lib/console_ui'
require_relative '../lib/gameboard'

system("cls") || system("clear")

describe ConnectFour  do
  subject(:game) { described_class.new }
  let(:ui) { instance_double(ConsoleUI) }
  let(:gameboard) { instance_double(Gameboard) }

  describe '#rules' do
    before do
      game.instance_variable_set(:@ui, ui)
      allow(ui).to receive(:out).once
    end

    it 'sends RULES to @ui once' do
      expect(ui).to receive(:out).once
      game.rules
    end
  end

  describe '#play' do
    context 'When @game_over? is false, false, true' do
      before do
        game.instance_variable_set(:@ui, ui)
        game.instance_variable_set(:@gameboard, gameboard)
        allow(Gameboard).to receive(:new).and_return(gameboard)
        allow(gameboard).to receive(:move)
        allow(gameboard).to receive(:game_over?).and_return(false, false, true)
        allow(ui).to receive(:player_move)
        allow(ui).to receive(:out)
        allow(game).to receive(:game_over_message)
      end

      it 'calls @ui.player_move twice' do
        expect(ui).to receive(:player_move).twice
        game.play
      end

      it 'sends the game over message to @ui.out' do
        expect(ui).to receive(:out).once
        game.play
      end
    end
  end
end
