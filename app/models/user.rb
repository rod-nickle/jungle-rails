class User < ApplicationRecord
  has_secure_password
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true


  def self.authenticate_with_credentials(email, password)
    # Remove leading/trailing spaces and force to lowercase.
    email = email.downcase.strip
    
    user = self.where("lower(email) = ?", [email]).first
    if user && user.authenticate(password)
      return user
    end
  end

end
