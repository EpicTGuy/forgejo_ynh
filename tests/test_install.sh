#!/bin/bash
# Test d'installation de Forgejo

set -e

# Variables
test_name="test_install"
log_dir="tests/logs"
log_file="$log_dir/$(date +%Y%m%d_%H%M%S)_${test_name}.log"

# Création du dossier de logs
mkdir -p "$log_dir"

# Fonction de logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$log_file"
}

log "=== Début du test d'installation ==="

# Test dry-run de l'installation
log "Test d'installation en mode dry-run..."
if yunohost app install ../forgejo_ynh --dry-run; then
    log "✓ Dry-run réussi"
else
    log "✗ Échec du dry-run"
    exit 1
fi

# Vérification que le service est configuré
log "Vérification de la configuration du service..."
if [ -f "/etc/systemd/system/forgejo.service" ]; then
    log "✓ Service systemd configuré"
else
    log "✗ Service systemd non trouvé"
    exit 1
fi

# Vérification que l'utilisateur existe
log "Vérification de l'utilisateur forgejo..."
if id forgejo >/dev/null 2>&1; then
    log "✓ Utilisateur forgejo créé"
else
    log "✗ Utilisateur forgejo non trouvé"
    exit 1
fi

# Vérification des dossiers
log "Vérification des dossiers..."
for dir in "/opt/forgejo" "/var/lib/forgejo" "/var/log/forgejo"; do
    if [ -d "$dir" ]; then
        log "✓ Dossier $dir créé"
    else
        log "✗ Dossier $dir manquant"
        exit 1
    fi
done

log "=== Test d'installation terminé avec succès ===" 