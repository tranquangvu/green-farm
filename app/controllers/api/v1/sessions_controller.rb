class Api::V1::SessionsController < Api::ApiController
  include Payload

  skip_before_action :authenticate!, only: [:create]

  def create
    user = User.find_for_database_authentication(email: params[:email])

    if user && user.valid_password?(params[:password])
      render json: @response.success(payload(user)), status: :ok
    else
      render json: @response.failure(error: 'Invalid Email/Password'), status: :unauthorized
    end
  end

  def destroy
    uid_secret = UidSecret.find_by(uid: current_user.uid)

    if uid_secret.update(secret: nil)
      render json: @response.success, status: :ok
    else
      render json: @response.failure(error: 'Sign out unsuccessfully'), status: :unprocessable_entity
    end
  end
end
