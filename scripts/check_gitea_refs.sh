#!/bin/bash
# Script pour vérifier la présence de références à Gitea dans le projet Forgejo_ynh

set -e

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Liste des fichiers à ignorer
IGNORE_FILES=(
    ".github/workflows/test.yml"
    "scripts/check_gitea_refs.sh"
    "CHANGELOG.md"
)

# Fonction pour vérifier si un fichier doit être ignoré
should_ignore() {
    local file="$1"
    for ignore_file in "${IGNORE_FILES[@]}"; do
        if [[ "$file" == *"$ignore_file"* ]]; then
            return 0  # Ignorer ce fichier
        fi
    done
    return 1  # Ne pas ignorer
}

# Recherche des références à Gitea
found_refs=false

while IFS= read -r -d '' file; do
    # Ignorer les fichiers .git
    if [[ "$file" == *"/.git/"* ]]; then
        continue
    fi
    
    # Ignorer les fichiers spécifiés
    if should_ignore "$file"; then
        continue
    fi
    
    # Vérifier si le fichier contient des références à Gitea
    if grep -q -E 'gitea|Gitea|GITEA' "$file" 2>/dev/null; then
        if [ "$found_refs" = false ]; then
            echo -e "${RED}Des références à Gitea ont été trouvées :${NC}"
            found_refs=true
        fi
        echo "$file"
    fi
done < <(find . -type f -print0)

if [ "$found_refs" = false ]; then
    echo -e "${GREEN}Aucune référence à Gitea trouvée dans le projet.${NC}"
    exit 0
else
    exit 1
fi
