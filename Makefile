# Makefile for lua-mode

VERSION="$(shell sed -nre '/^;; Version:/ { s/^;; Version:[ \t]+//; p }' lua-mode.el)"
DISTFILE = lua-mode-$(VERSION).zip

default:
	@echo version is $(VERSION)

dist:
	rm -f $(DISTFILE) && \
	zip $(DISTFILE) -r . -x ".git/*" "*.gitignore" "*.zip"

release:
	git diff --exit-code && \
	git tag -a -m "Release tag" rel-$(VERSION) && \
	git push origin master && git pull origin master && \
	woger lua-l lua-mode lua-mode "release $(VERSION)" "Emacs major mode for editing Lua files" release-notes-$(VERSION) http://github.com/immerrr/lua-mode/
	@echo 'Send update to ELPA!'
