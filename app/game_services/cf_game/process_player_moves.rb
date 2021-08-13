# frozen_string_literal: true

require 'matrix'

module CfGame
  class ProcessPlayerMoves
    def initialize(player_id:, player_moves:, game:)
      @player_id = player_id.to_i
      @player_moves = player_moves
      @game = game
      @column = @player_moves.try { |moves| moves[:column].to_i }
    end

    def call
      return false if player_id.zero?
      return false if column.blank?
      return false unless target_column.first.zero?
      return false if player_matrix_id != game.session_data['player_turn']
      return false unless game.session_data['game_status'].blank?

      matrix = game.session_data['board_matrix']
      matrix[last_filled_row][column] = player_matrix_id
      game.session_data['board_matrix'] = matrix
      game.session_data['player_turn'] = player_matrix_id == 1 ? 2 : 1
      game.save!
      # TODO: Call Won Detection services
    end

    private

    def player_matrix_id
      return 1 if player_id == game.player_one_id

      2
    end

    def last_filled_row
      @last_filled_row ||= (target_column.find_index { |v| [1, 2].include? v } || target_column.length) - 1
    end

    def column_matrix
      @column_matrix ||= Matrix[*game.session_data['board_matrix']].transpose.to_a
    end

    def target_column
      @target_column = column_matrix[column]
    end

    attr_accessor :player_id, :player_moves, :game, :column
  end
end
