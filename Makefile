LUA_SOURCES := $(shell find . -type f -name '*.lua')
CHECK_TOOLS += stylua

include vendor/mk/base.mk
include vendor/mk/readme.mk

build:
.PHONY: build

clean:
.PHONY: clean

check: checktools check-stylua ## Checks all linting, styling, & other rules
.PHONY: check

check-stylua: ## Checks Lua modules for linting rules
	@echo "--- $@"
	stylua --check $(LUA_SOURCES)
.PHONY: check-stylua

test:
.PHONY: test

update-toc: ## Update README.md table of contents
	markdown-toc -i README.md
.PHONY: update-toc
