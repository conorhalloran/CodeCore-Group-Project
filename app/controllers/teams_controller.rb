class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    # @team = Team.new(team_params)
  end

  private

  # def team_params
  #   params.require(:team).permit(
  #                           :name,
  #                           {memberships_attributes: [:id, :user]}
  #                         )
  # end
end
