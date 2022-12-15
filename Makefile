CMD=emerge
GR="\033[1;32m"
NC="\033[0m"
PREFIX=">>>>>>>> "

.PHONY: all
all: sync update rebuild clean

.PHONY: sync
sync:
	@echo -e $(GR)$(PREFIX)syncing portage..$(NC)
	$(CMD) --sync -qv

.PHONY: update
update:
	@echo -e $(GR)$(PREFIX)updating apps..$(NC)
	$(CMD) -avDuNt --quiet-build=y --keep-going=y @world

.PHONY: rebuild
rebuild:
	@echo -e $(GR)$(PREFIX)rebuilding apps..$(NC)
	$(CMD) -1t --quiet-build=y @preserved-rebuild

.PHONY: clean
clean:
	@echo -e $(GR)$(PREFIX)removing unused apps..$(NC)
	$(CMD) --depclean
