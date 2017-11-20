class Admin::DashboardController < ApplicationController
  before_action :new_user

  def index
      @stats = {
        event_count: Event.count
      }

      @users = User.all
    end

  def new_user
      @user = User.new
  end

end
