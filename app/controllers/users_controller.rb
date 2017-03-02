class UsersController < ApplicationController
  before_action :isuser, only: [:edit]
  before_action :set_message, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
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
  
  def following
    @user = User.find(params[:id])
    @following = @user.following_users
    @relationship = @user.following_relationships.count
  end
  
  def follower
    @user = User.find(params[:id])
    @follower = @user.follower_users
    @relationship = @user.follower_relationships.count
  end
  
  def favoriting
    @user = User.find(params[:id])
    @microposts = @user.favorite_microposts
    @favorites = @user.favorites.count
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile, :address)
  end
  
  def set_message
    @user = User.find(params[:id])
  end
  
  def isuser
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path, notice: "ログイン情報が一致しません"
    end
  end
  
  
end
