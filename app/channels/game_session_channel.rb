class GameSessionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_session_channel_#{params[:id]}"
    ActionCable.server.broadcast "game_session_channel_#{params[:id]}", data: "player #{params[:player_id]} subscribed!"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    ActionCable.server.broadcast "game_session_channel_#{params[:id]}", data: "player #{params[:player_id]} unsubscribed!"
  end
end
