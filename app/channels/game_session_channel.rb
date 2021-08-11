class GameSessionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_session_channel_#{params[:id]}"
    ActionCable.server.broadcast "game_session_channel_#{params[:id]}", data: 'one client connected'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    ActionCable.server.broadcast "game_session_channel_#{params[:id]}", data: 'one client disconected'
  end
end
