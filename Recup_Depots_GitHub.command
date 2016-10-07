#!/bin/bash

# +---------------------------------------------------------------------------+
# |  Fichier     : Recup_Depots_GitHub.command                                |
# |  Version     : 1.0.0                                                      |
# |  Auteur      : Bruno Boissonnet                                           |
# |  Date        : 07/10/2016                                                 |
# |  Description : Récupère tous mes dépôts sur GitHub.                       |
# +---------------------------------------------------------------------------+


NOM_UTILISATEUR=boissonnfive

# On se met dans le répertoire du script
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir


# Récupère la liste de mes URLs de dépôts sur GitHub
# 1. Récupère la liste des dépôts (format JSON avec de nombreuses entrées)
# 2. Filtre les lignes "clone_url"
# 3. Supprime ce qu'il y a avant l'URL du dépôt
# 4. Supprime ce qu'il y a après l'URL du dépôt
mesDepots=$(curl -i -s https://api.github.com/users/$NOM_UTILISATEUR/repos | sed -n '/clone_url/s/.* \"clone_url\": "//p' | sed 's/\",//')
# echo $mesDepots


# Fait un clone de chaque dépôt dans le dossier en cours
for i in $mesDepots; do
	echo $i
	git clone $i
done

exit

