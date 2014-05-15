class Csv::PouleMatchesController < ApplicationController
    require 'csv'

  def create
    f = Tempfile.new('poules.csv')

    # get players with score
    players = get_players(params[:csv])

    # get poules
    poules = get_poules(players)

    # get matches by poules
    matches = get_matches(poules)

    # sort players by score DESC
    # players = players.sort_by{|k, v| -v}

    # creates poules CSV
    CSV.open(f.path, 'w', {col_sep: ";"}) do |csv_object|
      # players.each do |player, score|
      #   csv_object << [player, score]
      # end
    end

    render json: poules
    # send_file f.path
  end

  private

    def get_players csv_file
      players = {}
      CSV.parse(csv_file.read, col_sep: ";") do |row|
        player = row[0]
        score = row[1]
        players[player] = score.to_i
      end

      # sort players by score DESC
      players = players.sort_by{|k, v| -v}

      return players
    end

    def get_poules players, poule_size = 2
      i = (players.size.to_f / poule_size.to_f).ceil
      players.each_slice(i)
    end

    def get_matches poules
    end
end
