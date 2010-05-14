$(call PKG_INIT_BIN, 1.17.3)
$(PKG)_SOURCE:=$(pkg)-$($(PKG)_VERSION)-freetz.tar.bz2
$(PKG)_SITE:=http://download.berlios.de/callmonitor
$(PKG)_BINARY:=$($(PKG)_DIR)/src/recode
$(PKG)_TARGET_BINARY:=$($(PKG)_DIR)/root/usr/lib/callmonitor/bin/recode
$(PKG)_STARTLEVEL=30
$(PKG)_SOURCE_MD5:=4399413cdb480d343510525247625c35

CALLMONITOR_FEATURES:=$(foreach feat,webif actions monitor phonebook,\
	$(if $(FREETZ_PACKAGE_CALLMONITOR_$(feat)),$(feat)))

$(PKG_SOURCE_DOWNLOAD)
$(PKG_UNPACKED)

.PHONY: FORCE

$(CALLMONITOR_DIR)/.features.new: FORCE
	@echo $(CALLMONITOR_FEATURES) > $@

$(CALLMONITOR_DIR)/.features: $(CALLMONITOR_DIR)/.features.new
	@if [ ! -e $@ ] || ! diff -q $< $@; then cp $< $@; fi

$($(PKG)_DIR)/.configured: $($(PKG)_DIR)/.unpacked $($(PKG)_DIR)/.features
	$(SUBMAKE) -C $(CALLMONITOR_DIR) configure
	@touch $@

$($(PKG)_BINARY): $($(PKG)_DIR)/.configured
	$(SUBMAKE) $(TARGET_CONFIGURE_ENV) -C $(CALLMONITOR_DIR) build

$($(PKG)_TARGET_BINARY): $($(PKG)_BINARY)
	$(INSTALL_BINARY_STRIP)
	chmod 755 $@

$(pkg)-clean: FORCE
	if [ -d "$(CALLMONITOR_DIR)" ]; then $(SUBMAKE) -C $(CALLMONITOR_DIR) clean; else true; fi

$(pkg) $(pkg)-precompiled: $($(PKG)_TARGET_DIR)/.packaged

$($(PKG)_TARGET_DIR)/.packaged: $(CALLMONITOR_DIR)/.configured $($(PKG)_TARGET_BINARY)
	rm -rf $(CALLMONITOR_TARGET_DIR)
	mkdir -p $(CALLMONITOR_TARGET_DIR)/root
	tar -c -C $(CALLMONITOR_DIR)/root --files-from=$(CALLMONITOR_DIR)/.files | \
		tar -x -C $(CALLMONITOR_DEST_DIR)
	cp $(CALLMONITOR_DIR)/.language $(CALLMONITOR_TARGET_DIR)/
	@touch $@

$(PKG_FINISH)
