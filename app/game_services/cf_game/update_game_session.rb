# frozen_string_literal: true

require 'matrix'

module CfGame
  class UpdateGameSession
    def initialize(game:, params:)
      @game = game
      @params = params
    end

    def call
      update_game_session
    end

    private

    attr_accessor :game, :params

    def update_game_session
      return unless params.try { |params| params[:reset].present? }

      game.session_data.update(
        board_matrix: board_matrix.to_a,
        player_turn: (rand 1..2),
        game_status: '',
        win_element_array: nil
      )
      game.save
    end

    def board_matrix
      @board_matrix ||= Matrix.build(6, 7) { 0 }
    end
  end
end
