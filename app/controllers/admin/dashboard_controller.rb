class Admin::DashboardController < ApplicationController
<<<<<<< HEAD
  def index
      @stats = {
        event_count: Event.count
      }

      @users = User.all
    end
=======
>>>>>>> Setup Admin
end
