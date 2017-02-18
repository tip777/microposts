class UsersController < ApplicationController
  before_action :set_message, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "更新しました"
    else
      redirect_to edit_user_path(@user), notice: "エラーです。"
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Samaple App"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile, :address)
  end
  
  def set_message
    @user = User.find(params[:id])
  end
end
