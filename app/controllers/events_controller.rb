class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, except: [:index, :show, :new, :create, :update]
  before_action :current_user
  before_action :get_users_relations

  def index
    @search_events = []
    if params[:search] != []
      @search_events = @events.clone
      @search_events = Event.search(params[:search]).order("created_at ASC")
    else
      render :index
    end
  end

  def show
    @tasks = @event.tasks.order(created_at: :desc)
  end

  def new
  end

  def edit
    @event = Event.friendly.find(params[:id])
    @team = @teams.find_by_event_id(@event.id)
  end

  def create
    @event = Event.new(event_params.except(:team_attributes))
    @event.user = current_user
    @event.save
    @team = Team.new(event_params[:team_attributes].except(:memberships_attributes))
    @team.event = @event
    @team.save
    @users_names_array = event_params[:team_attributes][:memberships_attributes][:user_id]
    @user_id_hash = {}
    @users_names_array.each do |u_n|
      @user_id_hash.merge!(@user_names.select {|k, v| v == u_n})
    end
    @user_id_hash.merge!({current_user.id => current_user.full_name})
    @user_id_hash.each_pair do |id, name|
      if id != ""
        @membership = Membership.new(event_params[:team_attributes][:memberships_attributes])
        @membership.team = @team
        if id == current_user.id
          @membership.user = current_user
          @membership.is_leader = true
          @membership.save
        else
          @membership.user = @users.find_by_id(id)
          @membership.save
        end
      end
    end
    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
        EventsMailer.notify_event_creator(@event).deliver_now
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @event.slug = nil
    @user_names = {}
    @message = @event.description
    @team = event.teams

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
        EventsMailer.leader_notify_guest(@event, @message).deliver_now

      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_event
    @event = Event.friendly.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
                          :event_type,
                          :name,
                          :location,
                          :description,
                          :user_id,
                          :team,
                          :leader_id,
                          :date,
                          :attachment,
                          :start_time,
                          :end_time,
                          :team_id,
                          {:team_attributes =>
                            [:id, :name,
                              {:memberships_attributes => {:user_id => []}}]}
                        )
  end

  def authorize_user!
    unless can?(:manage, @event)
      flash[:alert] = "Access Denied!"
      redirect_to root_path
    end
  end

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
end
