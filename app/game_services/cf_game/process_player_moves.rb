# frozen_string_literal: true

module CfGame
  class ProcessPlayerMoves
    def initialize(player_id:, player_moves:, game:)
      @player_id = player_id
      @player_moves = player_moves
      @game = game
    end

    def call
      # TODO: Implements Player movements and call won detection
      matrix = @game.session_data['board_matrix']
      matrix[rand 0..5][rand 0..6] = rand 1..2
      @game.session_data['board_matrix'] = matrix
      @game.save!
    end

    private

    attr_accessor :player_id, :player_moves, :game
  end
end
