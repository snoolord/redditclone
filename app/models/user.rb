require 'securerandom'


class User < ActiveRecord::Base
  validates :password_digest, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(username, password)
    potential_user = User.find_by_username(username)
    return nil unless potential_user
    potential_user.is_password?(password) ? potential_user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  private
  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end
