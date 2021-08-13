class Game < ApplicationRecord
  validates :player_one_id, presence: true, uniqueness: true
  validates :player_two_id, presence: true, uniqueness: true

  store_accessor :session_data, :game_board_partial, :player_move_processor
end
