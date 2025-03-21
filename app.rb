require 'sinatra'
require 'sinatra/reloader' if development?
require 'rack-livereload' if development?
require 'sinatra/activerecord'
require 'bcrypt'


# Utiliser le port défini par l'environnement ou 8080 par défaut
set :port, ENV.fetch("PORT", 8080)
# Faire écouter l'application sur toutes les interfaces
set :bind, '0.0.0.0'

# Configure SQLite3 pour l'environnement de développement
set :database, { adapter: "sqlite3", database: "db/development.sqlite3" }

# Route pour la page d'accueil
get '/' do
  erb :index
end