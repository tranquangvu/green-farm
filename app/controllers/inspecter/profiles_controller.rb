class Inspecter::ProfilesController < Inspecter::BaseController
  def show
  end

  def edit
  end

  def update
  end

  private

  def set_user

  end

  def profile_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :current_password)
  end
end
