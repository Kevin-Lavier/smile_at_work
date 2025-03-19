require 'sinatra'

# Utilise la variable d'environnement PORT, ou 8080 par défaut
set :port, ENV.fetch("PORT", 8080)

get '/' do
  "Hello, world!"
end
