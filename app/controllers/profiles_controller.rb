class ProfilesController < ApplicationController
  layout 'profile'

  before_action :authenticate_user!, except: [:show]
  before_action :set_user

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user ||= User.find(params[:id])
  end

  def profile_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password)
  end
end
