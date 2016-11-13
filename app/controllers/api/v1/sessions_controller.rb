class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate!, only: [:create]

  def create
    user = User.find_for_database_authentication(email: params[:email])

    if user && user.valid_password?(params[:password])
      render json: @response.success(payload(user)), status: :ok
    else
      render json: @response.success({ errors: ['Invalid Email/Password'] }), status: :unauthorized
    end
  end

  def destroy
    uid_secret = UidSecret.find_by(uid: current_user.uid)

    if uid_secret.update(secret: nil)
      render json: @response.success, status: :ok
    else
      render json: @response.failure(errors: uid_secret.errors.full_messages), status: :unprocessable_entity
    end
  end

  private

  def payload(user)
    return { auth_token: JsonWebToken.encode({ user_id: user.id.to_s }, secret(user)),
             user: { id: user.id.to_s, email: user.email },
             uid: user.uid } if user && user.id
  end

  def secret(user)
    secret = SecureRandom.hex(64)
    UidSecret.find_by(uid: user.uid).update(secret: secret)
    secret
  end
end
