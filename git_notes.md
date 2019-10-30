# git / github.com

<!-- MarkdownTOC uri_encoding="false" -->

- [COMMENT J'UTILISE GIT & GITHUB](#user-content-comment-jutilise-git--github)
- [CRÉATION DU PREMIER PROJET](#user-content-création-du-premier-projet)
- [POSER UNE ÉTIQUETTE \(TAG\)](#user-content-poser-une-étiquette-tag)
- [CONFIGURER GIT](#user-content-configurer-git)
- [UTILISER PRO DE TRISTAN HUME](#user-content-utiliser-pro-de-tristan-hume)
- [COMMANDES GIT SUPPLÉMENTAIRES](#user-content-commandes-git-supplémentaires)
- [Différence entre checkout et reset](#user-content-différence-entre-checkout-et-reset)
- [GITHUB.COM](#user-content-githubcom)
- [GIT SUR WINDOWS](#user-content-git-sur-windows)
- [GIT PAR MARC](#user-content-git-par-marc)
- [BIBLIOGRAPHIE](#user-content-bibliographie)
- [GLOSSAIRE](#user-content-glossaire)

<!-- /MarkdownTOC -->

## COMMENT J'UTILISE GIT & GITHUB

1. **pro status** => quel est le statut de mes dépôts
(mes dépôts sont dans les dossiers renseignés dans le fichier ~/.proBase
2. **pd repos** => Je vais dans le dépôts concerné (repos peut être un bout du nom du dépôt - alias défini dans ~/.bash_profile)
3. **gs + ga + gcm + gpom** => mes alias pour utiliser git (fichier ~/.bash_profile)

## CRÉATION DU PREMIER PROJET

1. On commence par créer un dépôt vide sur github.com (Ex: Projet1).
2. GitHub nous donne l'addresse du dépôt. Exemple :

        https://github.com/boissonnfive/Projet1.git

3. On revient en local sur son ordinateur.
4. On se place dans le dossier de son projet.
5. On lance git dans un terminal dans ce dossier.
6. On tape la commande :

        $ git init

7. On ajoute tous les fichiers/dossiers du projet en tapant (pour chaque fichier) :

        $ git add fichier

    Ou (pour tous les fichiers d'un coup) :

        $ git add .

8. On fait un commit :

        $ git commit -m "Première consigne"

9. On définit l'adresse du serveur de dépôt (avec l'adresse du 2):

        $ git remote add origin https://github.com/boissonnfive/Projet1.git

10. On remonte les modifications sur le dépôt en tapant :

        $ git push origin master

11. À la prochaine modification en local sur un fichier, on tapera :

        $ git add .
        $ git commit -m "ce qu on vient de modifier"

12. Et on exportera les modifications sur le dépôt distant en tapant :

        $ git push origin master

13. Si on veut supprimer le dernier commit (avant d'avoir fait un push) :
[ATTENTION : Les modifications du dernier commit sont supprimées du fichier!]
(Dans le log, le dernier commit n'apparaît plus)

        $ git reset --hard HEAD~1

14. Si on veut supprimer un (ou des) fichier(s) de la zone d'attente (staged)
[Les modifications dans les fichiers sont conservées]

        $ git reset HEAD "nom du fichier"

    ou

        $ git reset HEAD .

15. Si on veut supprimer un fichier du dépôt
[Le fichier est effacé du disque]

        git rm fichier.txt
        git commit -m "Suppression du fichier fichier.txt"

16. Si on veut supprimer un fichier du dépôt, mais pas du disque

        git rm --cached fichier.txt
        git commit -m "Suppression du fichier fichier.txt"

17. À tout moment, on peut savoir où on en est par la commande :

        $ git status

18. A tout moment, on peut savoir tout ce qui a été fait par la commande :

        $ git log

19. Si on a travaillé à partir d'un autre ordinateur (ou qu'une autre personne a travaillé sur le projet) et que l'on veut récupérer les modifications :

        $ git pull origin master

20. Si on veut modifier quelque chose sur un projet, il vaut mieux travailler sur une branche :

        $ git branch ajout
        $ git checkout ajout

21. Pour faire des modifications, c'est toujours le même processus : add + commit
22. Pour rapatrier les modifications sur la branche principale

        $ git checkout master
        $ git merge ajout

23. On efface la branche inutile :

        $ git branch -d ajout


## POSER UNE ÉTIQUETTE (TAG)

Donne la liste des étiquettes déposées sur le projet:

    $ git tag  # ou : $ git tag --list

Pose une étiquette sur le projet:

    $ git tag v0.0.1  # ou : $ git tag -a 'v0.0.1' -m 'première version du logiciel'

Pose l'étiquette sur le dépôt partagé (**après avoir fait un git push origin master**) :

    $ git push origin v0.0.1  # ou : $ git push origin master --tags


**Déplacer l'étiquette (tag) sur un nouveau commit**

1. Delete the tag on any remote before you push :

        $ git push origin :refs/tags/<tagname>

2. Replace the tag to reference the most recent commit :

        $ git tag -fa <tagname>

3. Push the tag to the remote origin :

        $ git push origin master --tags




## CONFIGURER GIT

### Paramètres globaux

    $ git config --global user.name "boissonnfive"
    $ git config --global user.email boissonnfive@gmail.com
    $ git config --list
    ...
    user.name=boissonnfive
    user.email=boissonnfive@gmail.com
    ...

### Paramètres locaux

Il est possible d'enregistrer un utilisateur par projet, quand celui-ci est différent de l'utilisateur global enregistré plus haut. Pour créer un utilisateur local au projet, on fera :

    $ git config user.name "binfoserviceDEV"
    $ git config user.email contact@binfoservice.fr
    $ git config --list
    ...
    user.name=binfoserviceDEV
    user.email=contact@binfoservice.fr
    ...


### Erreur 403 lors d'un push

    git push origin master
    remote: Permission to boissonnfive/Mon_GIT.git denied to expansia.
    fatal: unable to access 'https://github.com/boissonnfive/Mon_GIT.git/': The requested URL returned error: 403

Il faut utiliser le bon utilisateur. Ici, __expansia__ n'est pas le propriétaire du dépôt « Mon_GIT ». Il faut utiliser l'utilisateur **boissonnfive**.

Pour vérifier le nom d'utilisateur qui sera utilisé pour le push, faire :

    $ git config --list

Et vérifier la valeur de `user.name`.


## UTILISER PRO DE TRISTAN HUME

[Dépôt GitHub](https://github.com/trishume/pro)

Ce petit logiciel ruby sert à lister les dépôts Git qui ont des modifications en cours, grâce à la commande :

    pro status

Ce logiciel va regarder dans les répertoires enregistrés dans son fichier **~/.proBase**. Voici le mien:

    /Users/bruno/Desktop/GitHub
    /Users/bruno/Library/Application Support/Sublime Text 3/Packages/User

Pour aller dans le répertoire qui contient une modif, on fait :

    pd partieDuNomDuRépertoire  # ex : pd app (pour AppleScript)

Enfin, on peut appliquer une commande à tous les dépôts en même temps avec la commande :

    pro run commande


## COMMANDES GIT SUPPLÉMENTAIRES

### Renommer un fichier

    $ git mv ancien_nom_fichier nouveau_nom_fichier
    $ git status # Pour vérifier
    $ git commit -m "ancien_nom_fichier devient nouveau_nom_fichier"
    $ git push origin ma_branch

### Relocaliser le dépôt distant :

    $ git remote -v # pour lister le dépôt distant
    origin https://github.com/boissonnfive/Projet1.git (fetch)
    origin https://github.com/boissonnfive/Projet1.git (push)
    $ git remote set-url origin https://github.com/boissonnfive/Nouveau-Projet.git
    $ git remote -v
    origin https://github.com/boissonnfive/Nouveau-Projet.git (fetch)
    origin https://github.com/boissonnfive/Nouveau-Projet.git (push)


### Retrouver les modifications faites dans les fichiers

**En cours et non mis en attente (staged)**

    $ git diff (no parameters)
    # Print out differences between your working directory and the index.

**Entre les fichiers mis en attente et la dernière consigne (commit)**

    $ git diff --cached
    # Print out differences between the index and HEAD (current commit).

**Entre les fichiers modifiés et non mis en attente et la dernière consigne**

    $ git diff HEAD
    # Print out differences between your working directory and the HEAD.

**Faire des comparaisons de fichiers UTF-16**

    $ git config --global diff.tool vimdiff      # or merge.tool to get merging too!
    $ git difftool commit1 commit2


### Revenir à un commit précédent (et tout supprimer après)

    # Reset the index and working tree to the desired tree
    # Ensure you have no uncommitted changes that you want to keep
    $ git reset --hard 56e05fced
    
    # Move the branch pointer back to the previous HEAD
    $ git reset --soft HEAD@{1}
    
    $ git commit -m "Revert to 56e05fced"


### Supprimer un ou plusieurs des derniers commits

    git push -f origin <last_known_good_commit>:<branch_name>
    git reset --hard <last_known_good_commit>


### Message « Detached HEAD »

Il faut créer une branche pour tout remettre sur master, voir [ici](https://www.git-tower.com/learn/git/faq/detached-head-when-checkout-commit)


## Différence entre checkout et reset

Un checkout c'est pour faire sortir du dépôt une certaine version/commit (mais quand on n'a pas mis de fichiers en attente — git add). Le checkout va écraser tous les fichiers du répertoire de travail avec ce qu'il y a dans le dépôt.

Par contre, si on a mis des fichiers en attente (staging avec git add), il faut utiliser `git reset` pour remettre à zéro la zone d'attente.

    $ git reset --hard‌
    # Pour effacer tous les fichiers indexés mais pas validés (commit => donc pas dans le dépôt) : on remet à zéro la zone d'attente et on efface les modifications (--hard)

    $ git reset HEAD <file>..." to unstage
    # Pour sortir un fichier de l'index (de la zone d'attente)

    $ git reset master
    Unstaged changes after reset:
    M   fichier2.txt
    # Le commit de la modification du fichier fichier2.txt a été supprimé (voir git log), mais la modification est encore dans le fichier car on n'a pas fait de `--hard` ni de checkout. Git a supprimé tous les commit supérieurs au dernier commit de la branche master. Mais les modifications sont restées (fichiers créés ou modifs dans les fichiers)


## GITHUB.COM

### Rapatrier un dépôt local sur GitHub (ou faire un fork à la main)

1. Créez un dépôt sur GitHub **sans ajouter de fichier README.md**.
2. Récupérez l’adresse du dépôt (ex :https://github.com/boissonnfive/LWC_travel-site.git)
3. Ajoutez l’adresse du dépôt distant :
 
        git remote add origin https://github.com/boissonnfive/LWC_travel-site.git

4. Ou modifiez l’adresse :

        git remote set-url origin https://github.com/boissonnfive/LWC_travel-site.git

5. Exportez le dépôt local sur GitHub :
 
        git push origin master


### Supprimer un dépôt sur GitHub

1. Aller dans le dépôt à supprimer.
2. Aller dans le menu settings (roue dentée) :

        https://github.com/YOUR-USERNAME/YOUR-REPOSITORY/settings

3. Sous la bannière **« Danger Zone »**, cliquer sur **« Delete this repository »**.
4. Lire les avertissements.
5. Pour vérifier que vous effacez le bon dépôt, tapez le nom du dépôt que vous voulez supprimer.
6. Cliquer sur **« Je comprends les conséquences, effacez ce dépôt »**.


### Compte boisonnfive

- identifiant  : boissonnfive
- mail         : boissonnfive@gmail.com

### Compte expansia

- identifiant  : expansia
- mail         : stagiaire_etn.ara@pcas.com

### Compte binfoserviceDEV

- identifiant  : binfoserviceDEV
- mail         : contact@binfoservice.fr

---

## GIT SUR WINDOWS

### Configuration de l'installation

- version : 2.5.3
- architecture : 32 bits
- "Use git from Git Bash only"
- "Check-out Windows style, commit Unix-style line endings"
- "Use MinTTY (the default terminal of MSys2)"
- "Disable file system caching"

### Notes

Puisque Git Bash fonctionne à partir de MSys2, il inclut :

- Une documentation : C:\Program Files\Git\mingw32\share\doc\git-doc\index.html
- Bash
- Perl 5.0
- Vim 7.4

---

## GIT PAR MARC

### Pourquoi Git ?

- Tracer par fonctionnalité plutôt que par fichier (commit)
- Travailler déconnecté

### Les consignes pour travailler avec Git

- la branche principale pour le projet qui tourne + les branches pour développer (git branch)
- => 1 compte Entreprise (organisation) + des comptes développeurs
- Ne pas autoriser les dev à rappatrier sur la branche principale => Notion de "Release master/Responsable intégration" à qui on doit faire une pull request
- git log,  git status, git rebase
- lire l'API rest pour comprendre mieux le fonctionnement (<https://developer.github.com/v3/>)
- Livre Progit de Scott Chacon

### Procédure Git avancée

1. On crée un compte "organisation"
2. On crée un compte "release master" (seul à avoir les droits sur le dépôt)
3. Chaque dévéloppeur se créer un dépôt
4. Les développeurs doivent faire une copie du dépôt principal (fork) pour travailler sur le projet.
5. Ils doivent faire un "pull" pour travailler en local.
6. Ils doivent faire un "push" pour rappatrier sur leur serveur.
7. Les dévéloppeurs devront faire une "pull request" pour demander au "release master" d'intégrer leurs modifs
8. Il y a désynchronisation des dépôts : dépôts dévéloppeur local/serveur + dépôt dévéloppeur/dépôt organisation.
9. On peut faire des "git reset" pour supprimer l'historique des commit, pour n'avoir qu'un seul commit lors de la "pull request".

---

## BIBLIOGRAPHIE

- [git the simple guide](http://rogerdudler.github.io/git-guide/)
- [Maîtriser Git en 28 minutes et 32 secondes](https://www.youtube.com/watch?v=5IcYILdejs8)
- [Hello World github](https://guides.github.com/activities/hello-world/)
- [ProGit de Scott Chacon](https://git-scm.com/book/fr/v2)


## GLOSSAIRE

- **Repository**   : Dépôt
- **Check in**     : Dépôt
- **To check in**  : Déposer, mettre en dépôt, faire un dépôt.
- **Check out**    : Retrait
- **To check out** : Retirer, récupérer (parfois rapatrier est une bonne alternative)
- **To commit**    : Consigner
- **Stage area**   : Zone d'attente
- **To stage**     : Mettre en attente
- **Change**       : Modification (à préférer à changement)
- **stash**        : Remise
- **To stash**     : Remiser
- **Checksum**     : Somme de contrôle
- **Hash**         : Empreinte (Alternatives: signature, hachage (correct mais à éviter))
- **Workflow**     : Processus (Alternative: scénario)
- **Snapshot**     : Instantané
- **Diff**         : Diff
- **To track**     : Suivre
- **untracked**    : non-suivi
- **unmodified**   : non-modifié
- **To update**    : Mettre à jour
