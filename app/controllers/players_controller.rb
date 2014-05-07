class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to players_url(), notice: "Successvol nieuwe player aangemaakt"
    else
      render :new, alert: "problemen met het maken van een nieuwe speler"
    end

  end

  private

    def player_params
      params.require(:player).permit(:first_name, :last_name, :gender)
    end
end
