class ProfilesController < ApplicationController
  layout 'profile'

  before_action :authenticate_user!, except: [:show]
  before_action :set_user
  before_action :owned_profile, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update_with_password(profile_params)
      bypass_sign_in(@user)
      redirect_to profile_path(@user)
    else
      render :edit
    end
  end

  private

  def set_user
    @user ||= User.find(params[:id])
    redirect_to root_path unless @user
  end

  def owned_profile
    unless current_user == @user
      flash[:alert] = "This profile isn't belongs to you"
      redirect_to profile(@user)
    end
  end

  def profile_params
    params.require(:user).permit(:email, :username, :password,
      :avatar, :avatar_cache, :password_confirmation, :current_password)
  end
end
