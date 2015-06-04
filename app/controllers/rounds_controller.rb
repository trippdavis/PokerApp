class RoundsController < ApplicationController
  def index
    @player1_wins = Round.where(winner_id: 1).count
    @player2_wins = Round.where(winner_id: 2).count
  end

  def show
    @round = Round.find(params[:id])
  end

  def find_show
    round_id = params["round_id"]
    if round_id.to_i > 0 && round_id.to_i <= 1000
      redirect_to "/rounds/" + round_id
    else
      flash[:errors] = "Enter a valid round number"
      redirect_to ""
    end
  end

end
