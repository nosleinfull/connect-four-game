class GameController < ApplicationController
  before_action :set_game, only: %i[show]

  def show; end

  private

  def set_game
    @game = Game.find_by(player_one_id: current_player) || Game.find_by!(player_two_id: current_player)
  end
end
