GITHUB_URL := https://github.com/intitni/CopilotForXcode/
ZIPNAME_BASE := Copilot.for.Xcode.app
APPCAST_PATH := ./appcast.xml

setup:
	echo "Setup."

# Usage: make appcast app=path/to/bundle.app tag=1.0.0 [channel=beta] [release=1]
appcast:
	$(eval RELEASEDIR := ~/Library/Caches/CopilotForXcodeRelease/$(shell uuidgen))
	$(eval BUNDLENAME := $(shell basename "$(app)"))
	$(eval WORKDIR := $(shell dirname "$(app)"))
	$(eval ZIPNAME := $(ZIPNAME_BASE)$(if $(channel),.$(channel).$(if $(release),$(release),1)))
	$(eval RELEASENOTELINK := $(GITHUB_URL)releases/tag/$(tag))
	mkdir -p $(RELEASEDIR)
	cp "$(APPCAST_PATH)" $(RELEASEDIR)/appcast.xml
	cd $(WORKDIR) && ditto -c -k --sequesterRsrc --keepParent "$(BUNDLENAME)" "$(ZIPNAME).zip"
	cd $(WORKDIR) && cp "$(ZIPNAME).zip" $(RELEASEDIR)/
	touch $(RELEASEDIR)/$(ZIPNAME).html
	echo "<body></body>" > $(RELEASEDIR)/$(ZIPNAME).html
	-sparkle/bin/generate_appcast $(RELEASEDIR) --download-url-prefix "$(GITHUB_URL)releases/download/$(tag)/" --release-notes-url-prefix "$(RELEASENOTELINK)" $(if $(channel),--channel "$(channel)")
	mv -f $(RELEASEDIR)/appcast.xml "$(APPCAST_PATH)"
	rm -rf $(RELEASEDIR)
	sed -i '' 's/$(ZIPNAME).html/$(tag)/g' "$(APPCAST_PATH)"

.PHONY: setup appcast
