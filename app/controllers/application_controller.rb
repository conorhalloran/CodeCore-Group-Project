class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :new_event

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def new_event
    @new_event = Event.new
  end
  helper_method :new_event

  private

  def authenticate_user!
    if !user_signed_in?
      redirect_to new_session_path, alert: 'You must sign in or sign up first!'
    end
  end
end
