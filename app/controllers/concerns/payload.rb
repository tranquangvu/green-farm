module Payload
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
