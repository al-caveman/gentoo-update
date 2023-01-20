CMD=emerge
GR="\033[1;32m"
NC="\033[0m"
PREFIX=">>>>>>>> "

.PHONY: all
all: sync upgrade rebuild depclean boots

.PHONY: sync
sync:
	@echo -e $(GR)$(PREFIX)syncing portage..$(NC)
	$(CMD) --sync

.PHONY: upgrade
upgrade:
	@echo -e $(GR)$(PREFIX)upgrading..$(NC)
	$(CMD) -avDuNt --quiet-build=y --keep-going=y @world

.PHONY: rebuild
rebuild:
	@echo -e $(GR)$(PREFIX)rebuilding..$(NC)
	$(CMD) -1t --quiet-build=y @preserved-rebuild

.PHONY: depclean
depclean:
	@echo -e $(GR)$(PREFIX)cleaning..$(NC)
	$(CMD) --depclean

.PHONY: boots
boots:
	@echo -e $(GR)$(PREFIX)syncing boots..$(NC)
	umount /boot
	mount --rbind /boot_secondary /boot
	bootctl update || true
	emerge --config gentoo-kernel
	umount /boot
	mount --rbind /boot_primary /boot
