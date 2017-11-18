class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :new_event

  def index

  end

end
