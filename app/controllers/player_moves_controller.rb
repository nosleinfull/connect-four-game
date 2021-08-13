class PlayerMovesController < ApplicationController
  before_action :set_game, only: %i[create]

  def create
    # TODO: Don't broadcast message if result is false
    result = @game.player_move_processor.constantize.new(
      player_id: params[:player_id],
      player_moves: params[:player_moves],
      game: @game
    ).call

    return unless result

    ActionCable.server.broadcast(
      "game_session_channel_#{@game.id}",
      data: 'change_board'
    )
  end

  private

  def set_game
    @game = Game.find_by(player_one_id: params[:game_id]) || Game.find_by!(player_two_id: params[:game_id])
  end
end
