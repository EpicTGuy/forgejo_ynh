# forgejo_ynh

🛠️ Projet de packaging de l'application Forgejo pour le système Yunohost.

## Objectif
Permettre l'installation de Forgejo via le catalogue Yunohost comme auto-hébergeable.

## Stack
- Shell
- Git
- Yunohost packaging
- Cursor (pilotage IA)

## Structure
- `manifest.json` : métadonnées de l'application Yunohost
- `scripts/install`, `remove`, `upgrade` : scripts d'installation
- `conf/` : configuration NGINX, système, etc.
- `prompts/` : prompts pilotant le développement via Cursor

## Plan d'action
- [ ] Étudier le package Forgejo existant
- [ ] Dupliquer la structure
- [ ] Adapter les URLs / chemins / binaire
- [ ] Tester localement
- [ ] Proposer à la communauté YunoHost
