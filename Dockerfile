# Utilise l'image officielle Ruby
FROM ruby:3.2

# Définit le répertoire de travail
WORKDIR /app

# Copie le Gemfile et le Gemfile.lock s'ils existent
COPY Gemfile* /app/

# Installe les dépendances via Bundler
RUN bundle install

# Copie le reste du code
COPY . /app

# Expose le port sur lequel Sinatra s'exécute
EXPOSE 4567

# Démarre l'application
CMD ["ruby", "app.rb"]
