class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :currect_user

    def index
    end

    def show
    end

    def new
        @user = User.new
    end

    def edit
    end

    def create
        @user = User.new(user_params)
        
        respond_to do |format|
          if @event.save
                # success
            else
                # redirect
            end
        end
    end

    def update
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to @user, notice: 'User was successfully updated.' }
                format.json { render :show, status: :ok, location: @event }
            else
                format.html { render :edit }
                format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        end
    end

    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to user_url, notice: 'User was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
        def set_user
            @event = Event.find(params[:id])
         end

        def user_params
            params.require(:event).permit(:name, :email, :phone_number, :password, :password_confirmation)
        end
end
