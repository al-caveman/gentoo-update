CMD=emerge

all: sync update rebuild clean

.PHONY: sync
sync:
	$(CMD) --sync -qv

.PHONY: update
update:
	$(CMD) -avDuNt --quiet-build=y --keep-going=y @world

.PHONY: rebuild
rebuild:
	$(CMD) -1t --quiet-build=y @preserved-rebuild

.PHONY: clean
clean:
	$(CMD) --depclean
