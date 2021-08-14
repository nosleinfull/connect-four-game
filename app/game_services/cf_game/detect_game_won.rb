# frozen_string_literal: true

require 'matrix'

module CfGame
  class DetectGameWon
    def initialize(game:)
      @game = game
    end

    def call
      setup_win if won_game?
      setup_draw if draw_game? && !won_game?
    end

    private

    attr_accessor :game

    def setup_win
      # TODO: We can identify the win inside de matrix (changing color in front-end)
      game.session_data['game_status'] = 'won'
      game.session_data['winner'] = last_move_value == 1 ? 'player_one' : 'player_two'
      game.save
    end

    def setup_draw
      game.session_data['game_status'] = 'draw'
      game.save
    end

    def matrix
      @matrix ||= game.session_data['board_matrix']
    end

    def column_matrix
      @column_matrix ||= Matrix[*game.session_data['board_matrix']].transpose.to_a
    end

    def last_row
      game.session_data['last_row']
    end

    def last_col
      game.session_data['last_col']
    end

    def last_move_value
      matrix[last_row][last_col]
    end

    def find_min_backward_slash
      row = last_row
      col = last_col
      while row.positive? && col.positive?
        row -= 1
        col -= 1
      end
      [row, col]
    end

    def find_min_forward_slash
      row = last_row
      col = last_col
      while row.positive? && col <= 6
        row -= 1
        col += 1
      end
      [row, col]
    end

    def won_backward_slash?
      matched_number = 0
      row, col = find_min_backward_slash

      while row <= 5 && col <= 6
        matrix[row][col] == last_move_value ? matched_number += 1 : matched_number = 0

        return true if matched_number == 4 && !last_move_value.zero?

        row += 1
        col += 1
      end

      false
    end

    def won_forward_slash?
      matched_number = 0
      row, col = find_min_forward_slash

      while row <= 5 && col >= 0
        matrix[row][col] == last_move_value ? matched_number += 1 : matched_number = 0

        return true if matched_number == 4 && !last_move_value.zero?

        row += 1
        col -= 1
      end
      false
    end

    def won_horizontal?
      return true if won_array?(matrix[last_row])

      false
    end

    def won_vertical?
      return true if won_array?(column_matrix[last_col])

      false
    end

    def won_array?(array)
      matched_number = 0
      array.each do |value|
        value == last_move_value ? matched_number += 1 : matched_number = 0
        return true if matched_number == 4 && !last_move_value.zero?
      end

      false
    end

    def won_game?
      #             O(NxM)          O(N)             O(N)                O(N)   = O(NXM) + O(N)
      @won_game ||= [won_vertical?, won_horizontal?, won_forward_slash?, won_backward_slash?].any?
    end

    def draw_game?
      !matrix.first.include? 0
    end
  end
end
