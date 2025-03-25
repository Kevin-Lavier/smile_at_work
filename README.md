# Smile at Work 😊

**Smile at Work** est une application web développée en Ruby et Sinatra qui permet aux employés d'indiquer leur humeur du jour en sélectionnant un emoji.  
Chaque utilisateur peut créer un compte, se connecter, et choisir un emoji qui sera affiché sur la page d'accueil sous forme de carte.  
Cette page affiche la dernière humeur de chaque utilisateur pour la journée.

---


## Fonctionnalités 🚀

- **Création de compte** : Inscription d'un utilisateur avec validation des champs (nom, email, mot de passe).
- **Connexion / Déconnexion** : Authentification sécurisée avec gestion de session.
- **Mise à jour du profil** : Modification du nom d'utilisateur.
- **Sélection d'humeur** : Choix d’un emoji représentant l’humeur du jour.
- **Page d'accueil** : Affichage de la date (français) + humeur des utilisateurs en grille.
- **Gestion des erreurs 404** : Page personnalisée.
- **Tâches Rake** : Pour vider les tables `moods` et `users`.

---

## Prérequis 📋

- Ruby (version 4.0.0)
- Bundler
- SQLite (base légère adaptée au projet)

---

## Installation et configuration ⚙️

1. Cloner le dépôt Git :
   - Ouvrir un terminal
   - Taper la commande suivante : `git clone https://github.com/ton-compte/smile_at_work.git`
   - Se rendre dans le dossier du projet : `cd smile_at_work`

2. Installer les dépendances :
   - Lancer la commande : `bundle install`

3. Configurer les variables d’environnement :
   - Créer un fichier nommé `.env` à la racine du projet
   - Ajouter la ligne suivante dans ce fichier :  
     `SESSION_SECRET="une_clé_hexadécimale_générée"`
   - Pour générer une clé, utiliser la commande suivante dans un terminal :  
     `openssl rand -hex 64`

---

## Mise en place de la base de données 💾

La base de données est déjà comprise dans le projet.

Si besoin, tu peux la créer manuellement :

1. Créer la base de données : `bundle exec rake db:create`  
2. Lancer les migrations : `bundle exec rake db:migrate`

---

## Exécution de l'application 🏃

1. Démarrer l’application : `ruby app.rb`  
2. Ouvrir un navigateur web  
3. Aller à l’adresse suivante : `http://localhost:8080`

---

## Déploiement sur Fly.io ☁️

1. Se connecter à son compte Fly.io :  
   `flyctl auth login`

2. Déployer l'application depuis le dossier du projet (celui contenant le fichier `fly.toml`) :  
   `flyctl deploy`

3. (Optionnel) Modifier le nombre d'instances à démarrer :  
   `flyctl scale count 2`

4. (Optionnel) Éteindre les instances :  
   `flyctl scale count 0`

5. Une fois déployée, accéder à l'application en ligne :  
   [https://smile-at-work.fly.dev](https://smile-at-work.fly.dev)

---

## Tâches Rake 🛠️

Des tâches Rake personnalisées permettent de vider les données si besoin :

- Pour vider la table des humeurs :  
  `bundle exec rake cleanup:clear_moods`

- Pour vider la table des utilisateurs :  
  `bundle exec rake cleanup:clear_users`
