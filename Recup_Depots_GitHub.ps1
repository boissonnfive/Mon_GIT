

# +---------------------------------------------------------------------------+
# |  Fichier     : Recup_Depots_GitHub.command                                |
# |  Version     : 1.0.0                                                      |
# |  Auteur      : Bruno Boissonnet                                           |
# |  Date        : 07/10/2016                                                 |
# |  Description : Récupère tous mes dépôts sur GitHub.                       |
# +---------------------------------------------------------------------------+


$NOM_UTILISATEUR = "boissonnfive"

# On se met dans le répertoire du script
$this_script_path = $(Get-Item $($MyInvocation.MyCommand.Path)).DirectoryName
Set-Location -path $this_script_path


# Récupère la liste de mes URLs de dépôts sur GitHub
# + Fait un clone de chaque dépôt dans le dossier en cours
(curl "https://api.github.com/users/$NOM_UTILISATEUR/repos?page=1&per_page=100").Content | ConvertFrom-Json | %{ $_.clone_url } | %{ & git clone $_ 2>&1 } | % { $_.ToString() }