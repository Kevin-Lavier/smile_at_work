require 'sinatra'

# Utiliser le port défini par l'environnement ou 8080 par défaut
set :port, ENV.fetch("PORT", 8080)
# Faire écouter l'application sur toutes les interfaces
set :bind, '0.0.0.0'

get '/' do
  "Hello, world!"
end
