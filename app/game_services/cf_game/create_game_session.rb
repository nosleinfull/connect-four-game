# frozen_string_literal: true

module CfGame
  class CreateGameSession
    def initialize(player_one_id:, player_two_id:, game_model:)
      @player_one_id = player_one_id
      @player_two_id = player_two_id
      @game_model = game_model
    end

    def call; end

    private

    attr_accessor :player_one_id, :player_two_id, :game_model
  end
end
