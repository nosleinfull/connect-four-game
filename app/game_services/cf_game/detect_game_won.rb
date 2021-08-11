# frozen_string_literal: true

module CfGame
  class DetectGameWon
    def initialize(game:)
      @game = game
    end

    def call; end

    private

    attr_accessor :game
  end
end
