MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
MAKEFLAGS += --jobs=2
.ONESHELL:

TESTS := $(shell find ./tests -type f -executable -print)
# temp targets to allow parallel tests
OUT := $(addsuffix .out,$(TESTS))

.PHONY: test
test:  $(OUT)  ## Run all tests

%.out:
	$(patsubst %.out,%,$@)

.PHONY: help
help: ## Show this help.
	@grep '.*:.*##' Makefile | grep -v grep  | sort | sed 's/:.* ##/:/g' | column -t -s:
