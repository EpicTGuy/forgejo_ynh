# Makefile Forgejo_ynh

.PHONY: help test test-install test-upgrade test-remove lint format clean install-local upgrade-local clean-cache ci

.DEFAULT_GOAL := help

help:
	@echo "Cibles disponibles :"
	@echo "  test           : Lancer tous les tests automatisés"
	@echo "  test-install   : Test d'installation"
	@echo "  test-upgrade   : Test de mise à jour"
	@echo "  test-remove    : Test de désinstallation"
	@echo "  lint           : Lancer le linter shellcheck sur les scripts"
	@echo "  format         : Formater les scripts (shfmt)"
	@echo "  clean          : Nettoyer les fichiers temporaires"
	@echo "  clean-cache    : Supprimer /opt/forgejo/tmp et les archives dans sources/"
	@echo "  install-local  : Installer l'app localement sur Yunohost"
	@echo "  upgrade-local  : Upgrade local depuis la branche courante"
	@echo "  ci             : Lancer lint + test (CI locale)"

# Tests

test: test-install test-upgrade test-remove
	@echo "✓ Tous les tests terminés"

test-install:
	@echo "=== Test d'installation ==="
	@cd tests && ./test_install.sh

test-upgrade:
	@echo "=== Test de mise à jour ==="
	@cd tests && ./test_upgrade.sh

test-remove:
	@echo "=== Test de désinstallation ==="
	@cd tests && ./test_remove.sh

# Qualité

lint:
	shellcheck scripts/* tests/*.sh || true

format:
	shfmt -w scripts/* tests/*.sh || true

# Nettoyage

clean:
	find . -name '*.bak' -delete
	find . -name '*.tmp' -delete
	rm -rf tests/logs/*

clean-cache:
	rm -rf /opt/forgejo/tmp
	rm -f sources/*.tar.gz sources/*.zip sources/*.tgz || true

# CI locale

ci: lint test

# Installation locale

install-local:
	sudo yunohost app install ./forgejo_ynh --debug

upgrade-local:
	sudo yunohost app upgrade forgejo -u ./forgejo_ynh --debug 