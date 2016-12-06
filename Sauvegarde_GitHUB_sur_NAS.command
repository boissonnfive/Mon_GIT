#!/bin/bash

# +---------------------------------------------------------------------------+
# |  Fichier     : Sauvegarde_GitHUB_sur_NAS.command                          |
# |  Version     : 1.0.0                                                      |
# |  Auteur      : Bruno Boissonnet                                           |
# |  Date        : 06/12/2016                                                 |
# |  Description : Sauvegarde mon dépôt GitHub sur le NAS.                    |
# +---------------------------------------------------------------------------+

# Constantes du script
declare -r DOSSIER_NAS=Bruno
declare -r DOSSIER_MONTAGE=/Volumes/Bruno
declare -r SOURCE=/Users/bruno/Downloads/git/
declare -r DESTINATION=/Volumes/Bruno/GitHub/


# ---------------------------- Fonctions du script ----------------------------

# Fonction principale
main()
{
	# On se met dans le répertoire du script
	dossier=$(repertoireDuScript)
	cd $dossier
	
	# Si on ne peut pas monter les serveurs Samba, on quitte
	#mount -t afp afp://bruno:brunobo@192.168.1.15/Bruno /Volumes/Bruno
	if ! monteLeDossierDuNAS ${DOSSIER_NAS} ${DOSSIER_MONTAGE} ; then
		echo "Impossible de monter le dossier //192.168.1.15/Bruno dans /Volumes/Bruno"
		RET=1
	else
		# Synchronisation du dossier
		sauvegardeRsync ${SOURCE} ${DESTINATION}
		RET=$?
	fi
	return $RET
}



# repertoireDuScript
# Récupère le chemin du répertoire contenant le script
# pas de paramètres
# retour: le chemin du répertoire contenant le script
repertoireDuScript()
{
	# On récupère le chemin du répertoire contenant le script
	dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
	echo $dir
}


# monteLeDossierDuNAS
# Monte le dossier du NAS
# $1: nom du dossier partagé sur le NAS
# $2: chemin du dossier de montage
# return: 0 si OK, 1 sinon
monteLeDossierDuNAS()
{
	# Création du dossier de montage
	mkdir ${2}
	mount -t afp afp://bruno:brunobo@192.168.1.15/${1} ${2}
}


# sauvegardeRsync
# Monte le dossier du NAS
# $1: chemin du dossier à sauvegarder
# $2: chemin du dossier de destination
# return: 0 si OK, 1 sinon
sauvegardeRsync()
{
	#rsync --dry-run -avuL ${1} ${2}
	rsync -avuL ${1} ${2}
}


# ------------------------------ Début du script ------------------------------
main
# -------------------------------- Fin du script ------------------------------

exit $?
