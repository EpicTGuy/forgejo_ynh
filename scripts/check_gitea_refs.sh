#!/bin/bash
# Script pour vérifier la présence de références à Gitea dans le projet Forgejo_ynh

set -e

# Couleurs pour l'affichage
RED='\033[0;31m'
NC='\033[0m'

# Recherche des occurrences
matches=$(grep -r --exclude-dir=.git --exclude='*CHANGELOG*.md' -E 'gitea|Gitea|GITEA' .)

if [ -n "$matches" ]; then
    echo -e "${RED}Des références à Gitea ont été trouvées :${NC}"
    echo "$matches"
    exit 1
else
    echo -e "\e[32mAucune référence à Gitea trouvée dans le projet.\e[0m"
fi 