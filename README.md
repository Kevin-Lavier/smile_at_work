Smile at Work 😊

Smile at Work est une application web développée en Ruby et Sinatra qui permet aux employés d'indiquer leur humeur du jour en sélectionnant un emoji. Chaque utilisateur peut créer un compte, se connecter, et choisir un emoji qui sera affiché sur la page d'accueil sous forme de carte. Cette page affiche la dernière humeur de chaque utilisateur pour la journée.





Table des matières

    Fonctionnalités 🚀

    Architecture du projet 🗂️

    Prérequis 📋

    Installation et configuration ⚙️

    Mise en place de la base de données 💾

    Exécution de l'application 🏃

    Déploiement sur Fly.io ☁️

    Tâches Rake 🛠️







Fonctionnalités 🚀

    Création de compte : Inscription d'un utilisateur avec validation des champs (nom, email, mot de passe) afin d'éviter les entrées incorrectes.

    Connexion / Déconnexion : Authentification sécurisée avec gestion de session.

    Mise à jour du profil : Possibilité pour un utilisateur de modifier son nom.

    Sélection d'humeur : Chaque utilisateur peut choisir un emoji représentant son humeur du jour.

    Page d'accueil : Affichage de la date du jour (formatée en français) et des cartes d'humeur, une par utilisateur, organisées dans une grille.

    Gestion des erreurs 404 : Une page personnalisée pour les routes non trouvées.

    Tâches Rake personnalisées : Pour nettoyer les tables moods et users si nécessaire.







Architecture du projet 🗂️

project_root/
├── app.rb                         # Point d'entrée de l'application
├── .env                           # Fichier pour les variables d'environnement (non suivi par Git)
├── .gitignore                     # Fichiers à ignorer (ex: .env, /db/*.sqlite3)
├── Dockerfile                     # Configuration Docker (optionnel)
├── fly.toml                       # Configuration Fly.io
├── Gemfile                        # Dépendances Ruby
├── Gemfile.lock                   # Verrouillage des versions des gems
├── Rakefile                       # Tâches Rake (ActiveRecord & personnalisées)
├── README.md                      # Ce fichier de documentation
├── db/                           # Base de données et migrations
│   ├── migrate/                  # Fichiers de migration
│   │   ├── 20250321151404_create_users.rb
│   │   └── 20250321153756_create_moods.rb
│   ├── development.sqlite3        # Base de données de développement (non suivie)
│   ├── development.sqlite3-shm
│   ├── development.sqlite3-wal
│   └── schema.rb                 # Schéma de la base généré après migrations
├── helpers/                      # Helpers pour l'application (ex: date_formatter.rb, current_user.rb)
├── lib/                          # Code complémentaire
│   └── tasks/                    # Tâches Rake personnalisées (ex: cleanup.rake)
├── models/                       # Modèles ActiveRecord (User, Mood)
├── public/                       # Fichiers statiques (images, styles)
│   ├── images/                   # Images (logo, backgrounds, favicon, etc.)
│   └── styles/                   # Feuilles de style CSS
└── views/                        # Templates ERB (index, layout, login, signin, profile, select_mood, not_found)







Prérequis 📋

    Ruby (version 4.0.0 pour éviter les problèmes de "Not authorized")

    Bundler (gestionnaire de gems)

    SQLite (base de données pour le développement)
    L'application est destinée à une petite structure
    et n'est pas destinée à une utilisation suffisamment complexe pour passer sur PostgreSQL par exemple.







Installation et configuration ⚙️

    Cloner le repository:

git clone https://github.com/ton-compte/smile_at_work.git

    Se rendre dans le dossier smile_at_work

cd smile_at_work

    Installer les dépendances du projet :

bundle install

Configurer les variables d'environnement :

    Créer un fichier .env à la racine du projet.

    Ajouter dans le .env :

        SESSION_SECRET="une_clé_hexadécimale_générée"
        La clé peut être générée par la commande dans un terminal bash
        en exécutant cette commande :

        export SESSION_SECRET=$(openssl rand -hex 64)


        

Mise en place de la base de données 💾

La base de données est déjà comprise dans le projet.
Au besoin, il est possible créer la base de données et de sa migration
en exécutant ces commandes :

    

bundle exec rake db:create
bundle exec rake db:migrate



Exécution de l'application 🏃

Pour démarrer l'application en mode développement :

ruby app.rb

Ensuite, ouvrir un navigateur et se rendre sur http://localhost:8080









Déploiement sur Fly.io ☁️

    S'authentifier avec Fly.io:

flyctl auth login

    Déploiement de l'app : dans le dossier du projet (contenant le fichier fly.toml), exécuter :

flyctl deploy

    Pour ajouter le nombre d'instances nécessaire au démarrage :

flyctl scale count 2

    Pour éviter de laisser tourner le serveur pour rien :

flyctl scale count 0


    Pour accéder au site une fois déployé : 

https://smile-at-work.fly.dev








Tâches Rake 🛠️

Des tâches personnalisées sont définies pour la maintenance de la base de données :

    Vider la table moods:

bundle exec rake cleanup:clear_moods

    Vider la table users:

    bundle exec rake cleanup:clear_users

