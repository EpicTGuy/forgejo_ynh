# Tests automatisés pour Forgejo_ynh

Ce dossier contient les scripts de tests pour le paquet Forgejo sur Yunohost.

## Philosophie
- Approche TDD (Test-Driven Development)
- Chaque fonctionnalité majeure doit avoir un ou plusieurs tests associés
- Les tests doivent être reproductibles et non destructifs

## Lancer les tests

Depuis la racine du projet :

```bash
make test
```

Ou directement :

```bash
./tests/test_install.sh
```

## À compléter
- Ajouter des tests pour la sauvegarde, la restauration, la mise à jour, la suppression, etc. 