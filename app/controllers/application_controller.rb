class ApplicationController < ActionController::Base
  def current_player
    params[:id]
  end

  helper_method :current_player
end
