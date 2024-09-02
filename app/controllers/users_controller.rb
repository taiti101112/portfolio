class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]


  def show
    @user = User.find_by(id: params[:id])
  end

  def new 
    @user = User.new
  end

  def edit
  end

  def update
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_user
    return if params[:id] == "sign_out" # ログアウトリクエストをスキップ
  
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to(root_path) unless @user == current_user
  end

end
