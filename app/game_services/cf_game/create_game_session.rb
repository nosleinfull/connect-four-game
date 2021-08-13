# frozen_string_literal: true

require 'matrix'

module CfGame
  class CreateGameSession
    def initialize(player_one_id:, player_two_id:, game_model:)
      @player_one_id = player_one_id
      @player_two_id = player_two_id
      @game_model = game_model
    end

    def call
      create_game_session
    end

    private

    attr_accessor :player_one_id, :player_two_id, :game_model

    def create_game_session
      game_model.create(
        player_one_id: player_one_id,
        player_two_id: player_two_id,
        session_data: {
          game_board_partial: 'cf_game/board',
          player_move_processor: 'CfGame::ProcessPlayerMoves',
          game_updator: 'CfGame::UpdateGameSession',
          board_matrix: board_matrix.to_a,
          player_turn: (rand 1..2),
          game_status: ''
        }
      )
    end

    def board_matrix
      @board_matrix ||= Matrix.build(6, 7) { 0 }
    end
  end
end
