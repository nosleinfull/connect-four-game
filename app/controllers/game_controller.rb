class GameController < ApplicationController
  before_action :set_game, only: %i[show]

  def show; end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
