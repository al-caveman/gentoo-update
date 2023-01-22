GRB="\033[1;32m"
GRN="\033[0;32m"
NC="\033[0m"
PREFIX=">>>>>>>> "

.PHONY: all
all: sync upgrade rebuild depclean boots fonts

.PHONY: sync
sync:
	@echo -e $(GRB)$(PREFIX)syncing portage..$(NC)
	emerge --sync

.PHONY: upgrade
upgrade:
	@echo -e $(GRB)$(PREFIX)upgrading..$(NC)
	umount /boot || true
	mount --rbind /boot_primary /boot
	emerge -aqvDuNt --keep-going=y @world
	umount /boot

.PHONY: rebuild
rebuild:
	@echo -e $(GRB)$(PREFIX)rebuilding..$(NC)
	emerge -aqvt1 --keep-going=y @preserved-rebuild

.PHONY: depclean
depclean:
	@echo -e $(GRB)$(PREFIX)cleaning..$(NC)
	emerge --depclean

.PHONY: boots
boots:
	@echo -e $(GRB)$(PREFIX)syncing boots..$(NC)
	umount /boot || true
	mount --rbind /boot_secondary /boot
	bootctl update || true
	emerge --config gentoo-kernel
	umount /boot

.PHONY: fonts
fonts:
	@echo -e $(GRB)$(PREFIX)syncing fonts..$(NC)
	sudo -u $(SUDO_USER) git -C /home/$(SUDO_USER)/.local/share/fonts/amiri pull
	sudo -u $(SUDO_USER) fc-cache
