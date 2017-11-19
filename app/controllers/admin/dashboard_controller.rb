class Admin::DashboardController < ApplicationController

  def index
      @stats = {
        event_count: Event.count
      }

      @users = User.all
    end


end
