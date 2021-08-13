class PlayerMovesController < ApplicationController
  before_action :set_game, only: %i[create]

  def create
    # TODO: Don't broadcast message if result is false
    CfGame::ProcessPlayerMoves.new(player_id: params[:player_id], player_moves: params[:column], game: @game).call
    ActionCable.server.broadcast "game_session_channel_#{@game.id}",
                                 data: "Player #{params[:player_id]} made a move!"
  end

  private

  def set_game
    @game = Game.find_by(player_one_id: params[:game_id]) || Game.find_by!(player_two_id: params[:game_id])
  end
end
