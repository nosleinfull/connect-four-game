class Game < ApplicationRecord
  validates :player_one_id, presence: true, uniqueness: true
  validates :player_two_id, presence: true, uniqueness: true
end
