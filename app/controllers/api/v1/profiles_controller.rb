class Api::V1::ProfilesController < Api::ApiController
  include Payload

  def show
    render json: @response.success(current_user.as_json(
      only: [:username, :email]
    )), status: :ok
  end

  def update
    if current_user.update_with_password(profile_params)
      bypass_sign_in(current_user)
      response_data = profile_params[:password] ? payload(current_user) :
        current_user.as_json(only: [:username, :email])
      render json: @response.success(response_data), status: :ok
    else
      render json: @response.failure(current_user.errors.full_messages.first), status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:email, :username, :password,
                                 :password_confirmation, :current_password)
  end
end