class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :current_user

    def index
        @user = User.all
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
          if @user.save
                session[:user_id] = @user.id

                format.html { redirect_to users_path, notice: 'User succesfully created' }
            else
                format.html { render :new }
            end
        end
    end

    def update
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to users_path, notice: 'User succesfully updated' }
            else
                format.html { render :edit }
          end
          
        end
    end

    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
        def set_user
            @user = User.find(params[:id])
         end

        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password, :password_confirmation)
        end
end
