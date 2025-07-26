#!/bin/bash
# Test de désinstallation de Forgejo

set -e

# Variables
test_name="test_remove"
log_dir="tests/logs"
log_file="$log_dir/$(date +%Y%m%d_%H%M%S)_${test_name}.log"

# Création du dossier de logs
mkdir -p "$log_dir"

# Fonction de logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$log_file"
}

log "=== Début du test de désinstallation ==="

# Vérification que l'app est installée
log "Vérification que Forgejo est installé..."
if yunohost app list | grep -q forgejo; then
    log "✓ Forgejo est installé, test de désinstallation possible"
else
    log "✗ Forgejo n'est pas installé, impossible de tester la désinstallation"
    exit 1
fi

# Test de désinstallation en mode dry-run
log "Test de désinstallation en mode dry-run..."
if yunohost app remove forgejo --dry-run; then
    log "✓ Dry-run de désinstallation réussi"
else
    log "✗ Échec du dry-run de désinstallation"
    exit 1
fi

# Vérification que le service peut être arrêté
log "Vérification que le service peut être arrêté..."
if systemctl stop forgejo; then
    log "✓ Service arrêté avec succès"
else
    log "⚠ Service déjà arrêté ou inexistant"
fi

# Vérification que le service peut être désactivé
log "Vérification que le service peut être désactivé..."
if systemctl disable forgejo; then
    log "✓ Service désactivé avec succès"
else
    log "⚠ Service déjà désactivé ou inexistant"
fi

# Vérification des dossiers à supprimer
log "Vérification des dossiers à supprimer..."
for dir in "/opt/forgejo" "/var/lib/forgejo" "/var/log/forgejo" "/etc/forgejo"; do
    if [ -d "$dir" ]; then
        log "✓ Dossier $dir existe (sera supprimé)"
    else
        log "⚠ Dossier $dir n'existe pas"
    fi
done

# Vérification de l'utilisateur à supprimer
log "Vérification de l'utilisateur à supprimer..."
if id forgejo >/dev/null 2>&1; then
    log "✓ Utilisateur forgejo existe (sera supprimé)"
else
    log "⚠ Utilisateur forgejo n'existe pas"
fi

# Vérification du fichier de service à supprimer
log "Vérification du fichier de service à supprimer..."
if [ -f "/etc/systemd/system/forgejo.service" ]; then
    log "✓ Fichier de service existe (sera supprimé)"
else
    log "⚠ Fichier de service n'existe pas"
fi

log "=== Test de désinstallation terminé avec succès ===" 