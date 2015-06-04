class RoundsController < ApplicationController
  def index
    @player1_wins = Round.where(winner_id: 1).count
    @player2_wins = Round.where(winner_id: 2).count
  end

  def show
    @round = Round.find(params[:id])
  end

end
