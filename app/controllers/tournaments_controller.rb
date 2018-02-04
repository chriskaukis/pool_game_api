class TournamentsController < ApplicationController
  def create
    tournament_creator = TournamentCreator.new(create_tournament_params)
    if tournament_creator.valid?
      tournament = tournament_creator.create_tournament
      render json: tournament
    else
      render json: tournament_creator.errors, status: :unprocessable_entity
    end
  end

  protected

  def create_tournament_params
    params.permit(:number_of_rounds, :number_of_pools, :number_of_teams, :pool_placement)
  end
end
