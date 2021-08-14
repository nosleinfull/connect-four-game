# frozen_string_literal: true

require 'rails_helper'
require 'matrix'

RSpec.describe CfGame::DetectGameWon do
  describe '#call' do
    let(:game) { CfGame::CreateGameSession.new(player_one_id: 3, player_two_id: 4, game_model: Game).call }
    subject { described_class.new(game: game).call }

    context 'Backward slash detection' do
      let(:matrix) do
        [[0, 1, 0, 1, 0, 0, 1],
         [0, 0, 1, 0, 1, 0, 0],
         [0, 2, 0, 1, 0, 2, 0],
         [1, 2, 2, 0, 1, 0, 1],
         [0, 1, 2, 2, 0, 0, 0],
         [2, 0, 1, 2, 2, 0, 1]]
      end

      context 'When there are backward slashes' do
        before do
          game.session_data['board_matrix'] = matrix
        end

        @wins = [[5, 4], [1, 2], [3, 2], [4, 3], [3, 4], [5, 6], [0, 1], [2, 1], [2, 3]]
        @matrix = [[0, 1, 0, 1, 0, 0, 1],
                   [0, 0, 1, 0, 1, 0, 0],
                   [0, 2, 0, 1, 0, 2, 0],
                   [1, 2, 2, 0, 1, 0, 1],
                   [0, 1, 2, 2, 0, 0, 0],
                   [2, 0, 1, 2, 2, 0, 1]]

        @matrix.each_with_index do |row, row_index|
          row.each_with_index do |_, col_index|
            if @wins.include?([row_index, col_index])
              it "detect backward slash won if last move was on #{[row_index, col_index]}" do
                game.session_data['last_row'] = row_index
                game.session_data['last_col'] = col_index
                subject
                expect(game.reload.session_data['game_status']).to eq('won')
              end
            else
              it "don't detect backward slash won if last move was on #{[row_index, col_index]}" do
                game.session_data['last_row'] = row_index
                game.session_data['last_col'] = col_index
                subject
                expect(game.reload.session_data['game_status']).to eq(nil)
              end
            end
          end
        end
      end
    end

    context 'Forward slash detection' do
      let(:matrix) do
        [[1, 0, 2, 0, 0, 2, 2],
         [0, 2, 0, 0, 2, 2, 0],
         [2, 0, 0, 2, 2, 0, 1],
         [0, 0, 2, 1, 0, 1, 0],
         [0, 0, 2, 0, 1, 0, 0],
         [2, 2, 0, 1, 0, 0, 2]]
      end

      context 'When there are forward slashes' do
        before do
          game.session_data['board_matrix'] = matrix
        end

        @wins = [[3, 2], [2, 3], [4, 4], [2, 6], [0, 5], [5, 0], [3, 5], [5, 3], [1, 4]]
        @matrix = [[1, 0, 2, 0, 0, 2, 2],
                   [0, 2, 0, 0, 2, 2, 0],
                   [2, 0, 0, 2, 2, 0, 1],
                   [0, 0, 2, 1, 0, 1, 0],
                   [0, 0, 2, 0, 1, 0, 0],
                   [2, 2, 0, 1, 0, 0, 2]]

        @matrix.each_with_index do |row, row_index|
          row.each_with_index do |_, col_index|
            if @wins.include?([row_index, col_index])
              it "detect forward slash won if last move was on #{[row_index, col_index]}" do
                game.session_data['last_row'] = row_index
                game.session_data['last_col'] = col_index
                subject
                @result = [row_index, col_index]
                expect(game.reload.session_data['game_status']).to eq('won')
              end
            else
              it "don't detect forward slash won if last move was on #{[row_index, col_index]}" do
                game.session_data['last_row'] = row_index
                game.session_data['last_col'] = col_index
                subject
                expect(game.reload.session_data['game_status']).to eq(nil)
              end
            end
          end
        end
      end
    end

    context 'Vertical detection' do
      let(:matrix) do
        [[2, 0, 1, 0, 0, 0, 0],
         [2, 0, 0, 2, 0, 1, 0],
         [2, 1, 2, 2, 0, 1, 2],
         [1, 1, 0, 2, 0, 2, 2],
         [1, 1, 1, 2, 0, 1, 2],
         [1, 1, 0, 0, 0, 0, 2]]
      end

      context 'When there are vertical fills' do
        before do
          game.session_data['board_matrix'] = matrix
        end

        @wins = [[4, 3], [3, 3], [3, 6], [1, 3], [5, 6], [2, 3], [3, 1], [2, 6], [2, 1], [5, 1], [4, 1], [4, 6]]
        @matrix = [[2, 0, 1, 0, 0, 0, 0],
                   [2, 0, 0, 2, 0, 1, 0],
                   [2, 1, 2, 2, 0, 1, 2],
                   [1, 1, 0, 2, 0, 2, 2],
                   [1, 1, 1, 2, 0, 1, 2],
                   [1, 1, 0, 0, 0, 0, 2]]

        @matrix.each_with_index do |row, row_index|
          row.each_with_index do |_, col_index|
            if @wins.include?([row_index, col_index])
              it "detect vertical won if last move was on #{[row_index, col_index]}" do
                game.session_data['last_row'] = row_index
                game.session_data['last_col'] = col_index
                subject
                @result = [row_index, col_index]
                expect(game.reload.session_data['game_status']).to eq('won')
              end
            else
              it "don't detect vertical won if last move was on #{[row_index, col_index]}" do
                game.session_data['last_row'] = row_index
                game.session_data['last_col'] = col_index
                subject
                expect(game.reload.session_data['game_status']).to eq(nil)
              end
            end
          end
        end
      end
    end

    context 'Horizontal detection' do
      let(:matrix) do
        [[0, 0, 0, 0, 0, 0, 0],
         [0, 0, 0, 2, 0, 0, 0],
         [0, 2, 2, 2, 2, 0, 0],
         [0, 0, 0, 2, 0, 0, 0],
         [0, 0, 0, 1, 1, 1, 1],
         [0, 0, 0, 0, 0, 0, 0]]
      end

      context 'When there are horizontal fills' do
        before do
          game.session_data['board_matrix'] = matrix
        end

        @wins = [[4, 4], [2, 4], [2, 2], [4, 5], [2, 1], [4, 3], [2, 3], [4, 6]]
        @matrix = [[0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 2, 0, 0, 0],
                   [0, 2, 2, 2, 2, 0, 0],
                   [0, 0, 0, 2, 0, 0, 0],
                   [0, 0, 0, 1, 1, 1, 1],
                   [0, 0, 0, 0, 0, 0, 0]]

        @matrix.each_with_index do |row, row_index|
          row.each_with_index do |_, col_index|
            if @wins.include?([row_index, col_index])
              it "detect horizontal won if last move was on #{[row_index, col_index]}" do
                game.session_data['last_row'] = row_index
                game.session_data['last_col'] = col_index
                subject
                @result = [row_index, col_index]
                expect(game.reload.session_data['game_status']).to eq('won')
              end
            else
              it "don't detect horizontal won if last move was on #{[row_index, col_index]}" do
                game.session_data['last_row'] = row_index
                game.session_data['last_col'] = col_index
                subject
                expect(game.reload.session_data['game_status']).to eq(nil)
              end
            end
          end
        end
      end
    end
  end
end
