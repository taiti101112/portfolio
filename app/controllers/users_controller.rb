class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end