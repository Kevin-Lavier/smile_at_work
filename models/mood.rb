# The Mood model represents a mood entry in the database.
# Each mood record is associated with a single user.
class Mood < ActiveRecord::Base
  belongs_to :user
end
