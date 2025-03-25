# Delete all records from the database tables
# This file contains Rake tasks to clear specific tables in the database.


# Delete all records from the 'moods' table

namespace :cleanup do
  desc "Supprime toutes les humeurs (cards) de la table moods"
  task clear_moods: 'db:environment' do
    Mood.delete_all
    puts "Toutes les humeurs ont été supprimées."
  end
end
# Execute "bundle exec rake cleanup:clear_moods" to clear all moods from the database


# Delete all records from the 'users' table

namespace :cleanup do
  desc "Supprime tous les users de la table users"
  task clear_users: 'db:environment' do
    User.delete_all
    puts "Tous les users ont été supprimées."
  end
end
# Execute "bundle exec rake cleanup:clear_users" to clear all users from the database