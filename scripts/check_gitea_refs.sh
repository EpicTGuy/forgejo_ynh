#!/bin/bash
# Script pour vérifier la présence de références à Gitea dans le projet Forgejo_ynh

set -e

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Recherche des références à Gitea en excluant les fichiers légitimes
matches=$(find . -type f \
  -not -path './.git/*' \
  -not -path './.github/workflows/*' \
  -not -name '*CHANGELOG*.md' \
  -not -name 'check_gitea_refs.sh' \
  -exec grep -l -E 'gitea|Gitea|GITEA' {} \; 2>/dev/null)

if [ -n "$matches" ]; then
    echo -e "${RED}Des références à Gitea ont été trouvées :${NC}"
    echo "$matches"
    exit 1
else
    echo -e "${GREEN}Aucune référence à Gitea trouvée dans le projet.${NC}"
    exit 0
fi
