class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :initiate_instance_variables

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def initiate_instance_variables
    @event = Event.new
    @user = User.new
    @team = Team.new
    @task = Task.new

    @events = Event.all
    @users = User.all
    @teams = Team.all
    @memberships = Membership.all
    @tasks = Task.all
    @user_names = {}
  end
  helper_method :initiate_instance_variables

  def get_users_relations
    @user_names = {}
    @users.each { |u| @user_names.merge!({u.id => u.full_name}) }
    @current_user_teams = []
    if current_user
      current_user.memberships.each do |mship|
        @current_user_teams << @teams.find_by_id(mship.team_id)
      end
    end
  end
  helper_method :get_users_relations

  private

  def authenticate_user!
    if !user_signed_in?
      redirect_to new_session_path, alert: 'You must sign in or sign up first!'
    end
  end
end
