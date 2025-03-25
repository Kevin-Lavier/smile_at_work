namespace :cleanup do
  desc "Supprime toutes les humeurs (cards) de la table moods"
  task clear_moods: 'db:environment' do
    Mood.delete_all
    puts "Toutes les humeurs ont été supprimées."
  end
end
