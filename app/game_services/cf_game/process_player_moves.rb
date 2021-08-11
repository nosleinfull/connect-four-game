# frozen_string_literal: true

module CfGame
  class ProcessPlayerMoves
    def initialize(player_moves:, game:)
      @player_moves = player_moves
      @game = game
    end

    def call; end

    private

    attr_accessor :player_moves, :game
  end
end
