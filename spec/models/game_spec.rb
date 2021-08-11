require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'Validations' do
    subject { build(:game) }
    it { should validate_uniqueness_of(:player_one_id) }
    it { should validate_uniqueness_of(:player_two_id) }
  end
end
