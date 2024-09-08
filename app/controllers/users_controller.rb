class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_user  
    @user = User.find(params[:id])
  end

  def correct_user
    # `@user` が存在し、かつ現在のユーザーと一致するかを確認
    redirect_to(root_path) unless @user && @user == current_user
  end
end
