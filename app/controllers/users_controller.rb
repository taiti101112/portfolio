class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]


  def show
    @user = User.find_by(id: params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_user  
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to(root_path) unless @user == current_user
  end

end
