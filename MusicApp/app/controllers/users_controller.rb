class UsersController < ApplicationController

    before_action :require_logged_out, only: [:new, :create]

    def new
        @user = User.new
        render :new
    end

    def show
        @user = User.find_by(id: [params[:id]])
        render :show
    end

    def index
        @users = User.all
        render :index
    end

    def create
        # debugger
        @user = User.new(user_params)
        if @user.save
            login!(@user)
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    private
    def user_params
        params.require(:banana).permit(:email, :password)
    end
end
