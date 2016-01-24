all:
	@echo Use publish, archive or gitio

publish:
	@mix hex.publish && MIX_ENV=docs mix hex.docs

archive:
	@mix compile && mix archive.build

gitio:
	@[ -n "$(VERSION)" ] && \
	curl -i http://git.io \
		-F "url=https://github.com/edib-tool/mix-edib/releases/download/v$(VERSION)/edib-$(VERSION).ez" \
		-F "code=edib-$(VERSION).ez" || \
	echo "No version set. (VERSION=x.y.z)"

### README / DOCS

toc:
	@doctoc README.md --github --maxlevel 4 --title '## TOC'

### TEST

spec:
	@MIX_ENV=test mix espec --cover
.PHONY: spec

test: spec
.PHONY: test

### LINT

lint:
	-MIX_ENV=lint mix dogma
	-MIX_ENV=lint mix credo --strict
