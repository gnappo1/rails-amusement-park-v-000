class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was successfully created."
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:error] = error_parser(@user.errors.messages.first)
      render :new
    end
  end

  def show
    redirect_to root_path unless logged_in
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated."
      redirect_to @user
    else
      flash[:error] = error_parser(@user.errors.messages.first)
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :height, :happiness, :nausea, :tickets, :admin)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end
