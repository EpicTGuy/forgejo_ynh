#!/bin/bash
# Test de mise à jour de Forgejo

set -e

# Variables
test_name="test_upgrade"
log_dir="tests/logs"
log_file="$log_dir/$(date +%Y%m%d_%H%M%S)_${test_name}.log"

# Création du dossier de logs
mkdir -p "$log_dir"

# Fonction de logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$log_file"
}

log "=== Début du test de mise à jour ==="

# Vérification que l'app est installée
log "Vérification que Forgejo est installé..."
if yunohost app list | grep -q forgejo; then
    log "✓ Forgejo est installé"
else
    log "✗ Forgejo n'est pas installé, impossible de tester la mise à jour"
    exit 1
fi

# Récupération de la version actuelle
current_version=$(yunohost app setting forgejo version 2>/dev/null || echo "unknown")
log "Version actuelle : $current_version"

# Test de mise à jour en mode dry-run
log "Test de mise à jour en mode dry-run..."
if yunohost app upgrade forgejo --dry-run; then
    log "✓ Dry-run de mise à jour réussi"
else
    log "✗ Échec du dry-run de mise à jour"
    exit 1
fi

# Vérification que le service est toujours actif
log "Vérification que le service est toujours configuré..."
if systemctl is-enabled forgejo >/dev/null 2>&1; then
    log "✓ Service toujours activé"
else
    log "✗ Service non activé après mise à jour"
    exit 1
fi

# Vérification de la configuration
log "Vérification de la configuration..."
if [ -f "/etc/forgejo/app.ini" ]; then
    log "✓ Configuration préservée"
else
    log "✗ Configuration perdue"
    exit 1
fi

# Vérification des permissions
log "Vérification des permissions..."
if [ -d "/var/lib/forgejo" ] && [ "$(stat -c %U /var/lib/forgejo)" = "forgejo" ]; then
    log "✓ Permissions préservées"
else
    log "✗ Permissions incorrectes"
    exit 1
fi

log "=== Test de mise à jour terminé avec succès ===" 