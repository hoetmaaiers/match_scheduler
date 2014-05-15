class Csv::WarmUpsController < ApplicationController
  require 'csv'

  def create

    # get players from CSV
    players = get_players(params[:csv])
    rounds = get_warm_up_rounds(players)

    f = Tempfile.new('warm_up_rounds.csv')

    CSV.open(f.path, 'w', {col_sep: ";"}) do |csv_object|

      rounds.each do |key, matches|
        csv_object << ["Round #{key}"]

        matches.each do |match|
          csv_object << [match[:player_1], 0, 0, match[:player_2]]
        end
      end
    end

    send_file f.path
  end

  private

    def get_players csv_file
      players = []
      CSV.parse(csv_file.read, col_sep: ";") do |row|
        players << row
      end
      return players.uniq.flatten
    end

    def get_warm_up_rounds players
      rounds = {
        one: [],
        two: [],
        three: []
      }

      %w(one two three).each do |i|

        players_pool = players.dup

        until players_pool.size == 0
          rounds[i.to_sym] << {
            player_1: players_pool.delete_at(rand(players_pool.size)),
            player_2: players_pool.delete_at(rand(players_pool.size))
          }
        end
      end

      rounds
    end
end
