# frozen_string_literal: true

require 'rails_helper'
require 'matrix'

RSpec.describe CfGame::DetectGameWon do
  describe '#call' do
    let(:game) { CfGame::CreateGameSession.new(player_one_id: 3, player_two_id: 4, game_model: Game).call }
    subject { described_class.new(game: game).call }

    # TODO: Test another contexts
    context 'Backward slash detection' do
      let(:matrix) do
        [[0, 1, 0, 1, 0, 0, 1],
         [0, 0, 1, 0, 1, 0, 0],
         [0, 2, 0, 1, 0, 2, 0],
         [1, 2, 2, 0, 1, 0, 1],
         [0, 1, 2, 2, 0, 1, 0],
         [2, 0, 1, 2, 2, 0, 1]]
      end

      before do
        game.session_data['board_matrix'] = matrix
      end

      context 'when the last move was on a filled backward slash, that all values are equal last move value' do
        it 'detect backward slash won and change game session data' do
          game.session_data['last_row'] = 2
          game.session_data['last_col'] = 3
          subject
          expect(
            game.reload.session_data['game_status']
          ).to eq('won')
        end

        it 'detect backward slash won and identify winner' do
          game.session_data['last_row'] = 2
          game.session_data['last_col'] = 3
          subject
          expect(
            game.reload.session_data['winner']
          ).to eq('player_one')
        end
      end

      context 'when the last move was on a backward slash, that not all values are equal last move value' do
        it 'detect backward slash won and change game session data' do
          game.session_data['last_row'] = 2
          game.session_data['last_col'] = 1
          subject
          expect(
            game.reload.session_data['game_status']
          ).to eq('won')
        end

        it 'detect backward slash won and identify winner' do
          game.session_data['last_row'] = 2
          game.session_data['last_col'] = 1
          subject
          expect(
            game.reload.session_data['winner']
          ).to eq('player_two')
        end
      end

      context 'when the last move was on a backward slash, that not all values are equal last move value' do
        it 'detect backward slash won and change game session data' do
          game.session_data['last_row'] = 2
          game.session_data['last_col'] = 1
          subject
          expect(
            game.reload.session_data['game_status']
          ).to eq('won')
        end

        it 'detect backward slash won and identify winner' do
          game.session_data['last_row'] = 2
          game.session_data['last_col'] = 1
          subject
          expect(
            game.reload.session_data['winner']
          ).to eq('player_two')
        end
      end
      # TODO: Create WIN HASH to loop and avoid repetitions
      context 'when last move was on a backward slash, that there are not wins' do
        it 'do not detect backward slash won' do
          game.session_data['last_row'] = 5
          game.session_data['last_col'] = 0
          subject
          expect(
            game.reload.session_data['game_status']
          ).to eq(nil)
        end

        it 'do not detect backward slash won' do
          game.session_data['last_row'] = 4
          game.session_data['last_col'] = 0
          subject
          expect(
            game.reload.session_data['game_status']
          ).to eq(nil)
        end

        it 'do not detect backward slash won' do
          game.session_data['last_row'] = 3
          game.session_data['last_col'] = 0
          subject
          expect(
            game.reload.session_data['game_status']
          ).to eq(nil)
        end

        it 'do not detect backward slash won' do
          game.session_data['last_row'] = 2
          game.session_data['last_col'] = 0
          subject
          expect(
            game.reload.session_data['game_status']
          ).to eq(nil)
        end

        it 'do not detect backward slash won' do
          game.session_data['last_row'] = 0
          game.session_data['last_col'] = 0
          subject
          expect(
            game.reload.session_data['game_status']
          ).to eq(nil)
        end
      end
    end
  end
end
