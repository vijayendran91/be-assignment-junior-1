class User < ApplicationRecord

  validates :password, :length => {:minimum => 8 }
  validates :email, :uniqueness => true

  has_many :bills

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def password
    @password
  end

  def password=(raw)
    @password = raw
    self.password_digest = BCrypt::Password.create(raw)
  end

  def is_password?(raw)
    BCrypt::Password.new(password_digest).is_password?(raw)
  end

end
