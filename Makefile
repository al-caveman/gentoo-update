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
	umount /boot || true
	mount --rbind /boot_primary /boot
	$(CMD) -aqvDuNt --keep-going=y @world
	umount /boot

.PHONY: rebuild
rebuild:
	@echo -e $(GR)$(PREFIX)rebuilding..$(NC)
	$(CMD) -aqvt1 --keep-going=y @preserved-rebuild

.PHONY: depclean
depclean:
	@echo -e $(GR)$(PREFIX)cleaning..$(NC)
	$(CMD) --depclean

.PHONY: boots
boots:
	@echo -e $(GR)$(PREFIX)syncing boots..$(NC)
	umount /boot || true
	mount --rbind /boot_secondary /boot
	bootctl update || true
	emerge --config gentoo-kernel
	umount /boot
