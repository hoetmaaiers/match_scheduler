class Csv::PoulesController < ApplicationController
  require 'csv'

  def create
    f = Tempfile.new('poules.csv')

    # calculate players score from CSV
    players = calculate_players_score(params[:csv])

    # sort players by score DESC
    players = players.sort_by{|k, v| -v}

    # creates poules CSV
    CSV.open(f.path, 'w', {col_sep: ";"}) do |csv_object|
      players.each do |player, score|
        csv_object << [player, score]
      end
    end

    # render json: players
    send_file f.path
  end

  private

    def calculate_players_score csv_file
      players = {}

      CSV.parse(csv_file.read, col_sep: ";") do |row|
        unless /round/i.match(row.join(""))

          player_1 = row[0]
          player_2 = row[3]

          score_1 = row[1].to_i
          score_2 = row[2].to_i
          # logger.info "DEBUG #{player_1} |#{score_1}-#{score_2}| #{player_2}"

          players[player_1] ||= 0
          players[player_1] += points_earned(score_1, score_2)

          players[player_2] ||= 0
          players[player_2] += points_earned(score_2, score_1)
        end
      end

      players
    end

    def points_earned my_score, opponent_score
      # logger.info "DEBUG #{my_score} - #{opponent_score}"
      return 3 if my_score > opponent_score
      return 1 if my_score == opponent_score
      return 0
    end
end
