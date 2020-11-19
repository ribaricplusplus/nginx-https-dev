SHELL := /bin/bash
DIR := $(shell pwd)
FILES := $(shell find src -type f -and -not -iname '*.m4')
M4FILES := $(shell find src -type f -and -iname '*.m4')
OUTFILES := $(shell ./scripts/listfiles.sh)
# If DISTDIR is changed, it must also be changed in scripts/listfiles.sh
DISTDIR := dist
M4ARGS := -I $(DIR)

ifeq ($(MAKECMDGOALS),dev)

M4ARGS := $(M4ARGS) -D 'M_DEV=true'

else

M4ARGS := $(M4ARGS) -D 'M_DEV=false'

endif

define copy-symlinks =
@echo "Copying symlinks"
@SRC=$$( find src -type l | awk '{ sub(/^src\//, "src/./") ; print $$0 }'); \
rsync -aR $$SRC $(DISTDIR);
endef

define m4-recipe =
@echo "Processing(M4)" $<
@DIRS=$$( echo $< | awk ' { parts = split($$0, arr, "/"); if (parts < 3) {print "EMPTY"} else { result = arr[2]; for(i = 3 ; i <= parts - 1 ; i++) { result = result "/" arr[i] }; print result }} ' ); \
if [ ! $$DIRS == "EMPTY" ]; then \
mkdir -p $(DISTDIR)/$$DIRS; \
fi; \
DESTDIR=$$( dirname $$( echo $< | awk ' { sub(/^src\//, "$(DISTDIR)/"); print $$0 } ' ) ); \
FILENAME=$$( basename $< ".m4" ); \
DEST=$$DESTDIR/$$FILENAME; \
if [ ! -d $(DISTDIR) ]; then \
mkdir $(DISTDIR); \
fi; \
m4 $(M4ARGS) $< > $$DEST;
endef

.PHONY: prod
prod : $(OUTFILES)
	$(copy-symlinks)

.PHONY: dev
dev : $(OUTFILES)
	$(copy-symlinks)

.PHONY: check
check : prod
	@nginx -t -c $(DIR)/dist/nginx.conf

.PHONY: clean
clean :
	@rm -rf dist

$(DISTDIR)/% : src/%.m4
	$(m4-recipe)

$(DISTDIR)/% : src/%
	@echo "Processing" $<
	@if [ ! -d $(DISTDIR) ]; then \
	mkdir $(DISTDIR); \
	fi; \
	SRC=$$( echo $< | awk '{ sub(/^src\//, "src/./") ; print $$0 }'); \
	rsync -aR $$SRC $(DISTDIR)

