# frozen_string_literal: true

require 'rails_helper'
require 'matrix'

RSpec.describe CfGame::CreateGameSession do
  describe '#call' do
    subject { described_class.new(player_one_id: 1, player_two_id: 2, game_model: Game).call }

    context 'when create new game session' do
      it 'creates a game session with board' do
        expect(
          subject.session_data['board_matrix']
        ).to eq(Matrix.build(6, 7) { 0 }.to_a)
      end

      it 'creates a game session with partial view injection' do
        expect(
          subject.session_data['game_board_partial']
        ).to eq('cf_game/board')
      end

      it 'creates a game session with player one' do
        expect(
          subject.player_one_id
        ).to eq(1)
      end

      it 'creates a game session with player two' do
        expect(
          subject.player_two_id
        ).to eq(2)
      end

      it 'creates a game session with player turn tag' do
        expect(
          subject.session_data['player_turn']
        ).to eq(2).or eq(1)
      end
    end
  end
end
