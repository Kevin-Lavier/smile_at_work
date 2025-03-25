require 'active_record'
require 'bcrypt'

# The User model represents a user in the application.
# It includes secure password handling and validations.
class User < ActiveRecord::Base
  # Adds methods to set and authenticate against a BCrypt password.
  # This mechanism requires a password_digest column in your database.
  has_secure_password

  # Validate that the email is present, unique, and follows a valid email format.
  validates :email, 
            presence: true, 
            uniqueness: true, 
            format: { 
              with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]{2,}\z/i, 
              message: "is not valid" 
            }

  # Validate that the name is present, has a maximum length, and only includes letters, spaces, apostrophes, or dashes.
  validates :name, 
            presence: true,
            length: { maximum: 30 },
            format: { 
              with: /\A[[:alpha:]\s'-]+\z/, 
              message: "only accepts letters, spaces, or dashes" 
            }

  # Validate that the password meets security requirements:
  # - At least 6 characters long.
  # - Contains at least one lowercase letter, one uppercase letter, one digit, and one special character.
  # - Does not contain any spaces.
  # The validation is applied when creating a new record or when the password is updated.
  validates :password, 
            length: { minimum: 6 },
            format: { 
              with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[^\s]+\z/, 
              message: "must contain at least 6 characters, including one uppercase, one lowercase, one digit, and one special character, with no spaces" 
            },
            if: -> { new_record? || !password.nil? }
end
