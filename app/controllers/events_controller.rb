class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, except: [:index, :show, :new, :create, :update]
  before_action :new_event
  before_action :new_user
  before_action :current_user
  before_action :get_users, only: [:new, :create, :index]
  before_action :get_users_names_and_ids, only: [:new, :create, :index]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @task = Task.new
    @teams = Team.all
    @current_user_teams = []
    current_user.memberships.each do |mship|
      @current_user_teams << @teams.find_by_id(mship.team_id)
    end

    @search_events = []

    if params[:search] != []
      @search_events = @events.clone
      @search_events = Event.search(params[:search]).order("created_at ASC")
    else
      render :index
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @tasks = @event.tasks.order(created_at: :desc)
    @task = Task.new
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @user_names = {}
    @event = Event.friendly.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params.except(:team_attributes))
    @event.user = current_user
    @event.save
    @team = Team.new(event_params[:team_attributes].except(:memberships_attributes))
    @team.event = @event
    @team.save
    @users_names_array = event_params[:team_attributes][:memberships_attributes][:user_id]
    @user_id_array = {}
    @users_names_array.each do |u_n|
      @user_id_array.merge!(@user_names.select {|k, v| v == u_n})
    end
    @user_id_array.merge!({current_user.id => current_user.full_name})
    @user_id_array.each_pair do |id, name|
      if id != ""
        if id == current_user.id
          @membership = Membership.new(event_params[:team_attributes][:memberships_attributes])
          # @membership.user_id = id
          @membership.user = current_user
          @membership.is_leader = true
          @membership.team = @team
          @membership.save
        else
          @membership = Membership.new(event_params[:team_attributes][:memberships_attributes])
          # @membership.user_id = id
          @membership.user = @users.find_by_id(id)
          @membership.team = @team
          @membership.save
        end
      end
    end
    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event.slug = nil
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def new_event
    @event = Event.new
    @team = Team.new
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.friendly.find(params[:id])
  end

  def new_user
    @user = User.new
  end

  def event_params
    params.require(:event).permit(
                          :event_type,
                          :name,
                          :location,
                          :description,
                          :user_id,
                          :leader_id,
                          :date,
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

  def get_users
    @users = User.all
  end

  def get_users_names_and_ids
    @users = User.all
    @user_names = {}
    @users.each { |u| @user_names.merge!({u.id => u.full_name}) }
  end


end
