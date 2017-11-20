class MembershipsController < ApplicationController
  def create
    mem = Membership.new
    event_name = params[:event].titleize
    event = @events.find_by_name(event_name)
    mem.user_id = current_user.id
    mem.team_id = event.teams[0].id
    if mem.save
      redirect_to root_path, notice: 'Team joined successfully.'
    else
    end
  end
end
