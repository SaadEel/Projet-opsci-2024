#!/bin/bash

# Variables
STRAPI_DIR="/home/seh22/Projet_Saad" # Chemin pour accéder au projet Strapi
POSTGRES_HOST="localhost" # Adresse de l'hôte PostgreSQL
POSTGRES_PORT="5432" # Port PostgreSQL
POSTGRES_DB="postgres" # Nom de votre base de données PostgreSQL
POSTGRES_USER="strapi" # Nom d'utilisateur PostgreSQL
POSTGRES_PASSWORD="safepassword" # Mot de passe PostgreSQL

# Création d'une base de données PostgreSQL
echo "Création de la base de données PostgreSQL..."
sudo docker run -dit -p 5432:5432 -e POSTGRES_PASSWORD=safepassword -e POSTGRES_USER=strapi --name strapi-pg postgres

# Installation des dépendances
echo "Installation des dépendances yarn..."
yarn install

# Configuration de Strapi
echo "Configuration de Strapi"
yarn create strapi-app ${nom_projet}

# Changement du répertoire vers le projet Strapi
cd $STRAPI_DIR

# Création d'une image docker de Strapi après avoir créé un Dockerfile
echo "Création d'une image docker de Strapi..."
docker compose up

# Lancement de Strapi
echo "Lancement de Strapi..."
yarn develop

# On crée la collection Product puis on récupère le code pour le frontend
echo "Recupération du code pour le frontend..."
git clone https://github.com/arthurescriou/opsci-strapi-frontend

# Changement du répertoire vers les fichiers du frontend
cd /opsci-strapi-frontend

# Installation des dépendances pour le frontend
echo "Installation des dépendances yarn..."
yarn install

# Compiler/minifier le frontend
echo "Compilation du frontend..."
yarn build

# Lancement de l'API de strapi
echo "Lancement de l'API de strapi..."
yarn dev
