# Changelog

Toutes les modifications notables du projet seront consignées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/).

## [12.0.0] - 2025-07-26
### Ajouté
- Première version de forgejo_ynh adaptée depuis gitea_ynh
- Intégration complète de Forgejo 12.0.0 (binaire, configuration, service)
- Scripts d’installation, mise à jour, sauvegarde, restauration, suppression
- Documentation et hooks Yunohost
- Tests automatisés complets (installation, upgrade, suppression)
- CI/CD avec GitHub Actions
- Support des architectures amd64 et arm64
- Intégration LDAP/SSO YunoHost complète
- Configuration PostgreSQL éoptimisée
- Sécurité renforcée (permissions, fail2ban, logrotate)
- Workflow Git complet testé (clone, push, issues, PR, merge)
- Backup et restauration validés
- Performance et stabilité confirmées