require 'sinatra'

# Utilisation de la variable d'environnement PORT, sinon port 4567 par défaut
set :port, ENV.fetch("PORT", 4567)

get '/' do
  "Hello, world!"
end
