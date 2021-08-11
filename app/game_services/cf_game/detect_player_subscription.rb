# frozen_string_literal: true

module CfGame
  class DetectPlayerSubscription
    def initialize(player_id:, type:, game:)
      @player_id = player_id
      @type = type
      @game = game
    end

    def call; end

    private

    attr_accessor :player_moves, :game, :type
  end
end
