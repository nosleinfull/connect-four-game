class GameController < ApplicationController
  before_action :set_game, only: %i[show update]

  def show; end

  def update
    @game.game_updator.constantize.new(
      game: @game,
      params: params
    ).call

    ActionCable.server.broadcast(
      "game_session_channel_#{@game.id}",
      data: 'change_board'
    )
  end

  private

  def set_game
    @game = Game.find_by(player_one_id: current_player) || Game.find_by!(player_two_id: current_player)
  end
end
