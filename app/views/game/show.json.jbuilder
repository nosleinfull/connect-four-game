json.extract! @game, :id, :player_one_id, :player_two_id, :session_data, :created_at, :updated_at
json.url game_url(@game, format: :json)
