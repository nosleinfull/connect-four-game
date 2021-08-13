class BoardController < ApplicationController
  before_action :set_game, only: %i[index]

  def index
    render partial: "game_views/#{@game.game_board_partial}", locals: { game: @game, player: params[:game_id] }
  end

  private

  def set_game
    @game = Game.find_by(player_one_id: params[:game_id]) || Game.find_by!(player_two_id: params[:game_id])
  end
end
